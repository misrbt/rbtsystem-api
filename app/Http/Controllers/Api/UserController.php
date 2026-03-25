<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\AuditLog;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules\Password;

class UserController extends Controller
{
    /**
     * Format user data for response (includes branch info).
     */
    private function formatUser(User $user): array
    {
        return [
            'id' => $user->id,
            'name' => $user->name,
            'username' => $user->username,
            'email' => $user->email,
            'role' => $user->role,
            'is_active' => $user->is_active,
            'branch_id' => $user->branch_id,
            'branch' => $user->branch ? [
                'id' => $user->branch->id,
                'branch_name' => $user->branch->branch_name,
                'brak' => $user->branch->brak,
                'brcode' => $user->branch->brcode,
            ] : null,
            'employee_id' => $user->employee_id,
            'department' => $user->department,
            'position' => $user->position,
            'phone_number' => $user->phone_number,
            'systems' => $user->systems->map(fn ($system) => [
                'id' => $system->id,
                'name' => $system->name,
                'slug' => $system->slug,
                'role' => $system->pivot->role,
                'is_active' => $system->pivot->is_active,
            ])->values()->toArray(),
            'system_ids' => $user->systems->pluck('id')->toArray(),
            'system_access' => $user->systems->mapWithKeys(fn ($system) => [
                $system->id => [
                    'enabled' => true,
                    'role' => $system->pivot->role,
                ],
            ])->toArray(),
            'created_at' => $user->created_at,
            'updated_at' => $user->updated_at,
        ];
    }

    /**
     * List all users.
     */
    public function index(Request $request): JsonResponse
    {
        $query = User::with(['branch', 'systems'])->orderBy('created_at', 'desc');

        if ($request->has('search')) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('name', 'ilike', "%{$search}%")
                  ->orWhere('username', 'ilike', "%{$search}%")
                  ->orWhere('email', 'ilike', "%{$search}%")
                  ->orWhere('employee_id', 'ilike', "%{$search}%");
            });
        }

        if ($request->has('role')) {
            $query->where('role', $request->role);
        }

        if ($request->has('is_active')) {
            $query->where('is_active', filter_var($request->is_active, FILTER_VALIDATE_BOOLEAN));
        }

        if ($request->has('branch_id')) {
            $query->where('branch_id', $request->branch_id);
        }

        $users = $query->get()->map(fn (User $user) => $this->formatUser($user));

        return response()->json([
            'success' => true,
            'data' => $users,
        ]);
    }

    /**
     * Create a new user.
     */
    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'username' => ['required', 'string', 'max:255', 'unique:users', 'alpha_dash'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:users'],
            'password' => ['required', 'confirmed', Password::min(8)->mixedCase()->numbers()->symbols()],
            'role' => ['sometimes', 'string', 'in:admin,user'],
            'is_active' => ['sometimes', 'boolean'],
            'branch_id' => ['nullable', 'integer', 'exists:branches,id'],
            'employee_id' => ['nullable', 'string', 'max:100', 'unique:users,employee_id'],
            'department' => ['nullable', 'string', 'max:255'],
            'position' => ['nullable', 'string', 'max:255'],
            'phone_number' => ['nullable', 'string', 'max:50'],
            'system_ids' => ['sometimes', 'array'],
            'system_ids.*' => ['integer', 'exists:systems,id'],
        ], [
            'username.unique' => 'This username is already taken.',
            'username.alpha_dash' => 'Username may only contain letters, numbers, dashes and underscores.',
            'email.unique' => 'This email is already registered.',
            'password.confirmed' => 'Password confirmation does not match.',
            'employee_id.unique' => 'This employee ID is already assigned.',
        ]);

        $user = User::create([
            'name' => $validated['name'],
            'username' => $validated['username'],
            'email' => $validated['email'],
            'password' => $validated['password'],
            'role' => $validated['role'] ?? 'user',
            'is_active' => $validated['is_active'] ?? true,
            'branch_id' => $validated['branch_id'] ?? null,
            'employee_id' => $validated['employee_id'] ?? null,
            'department' => $validated['department'] ?? null,
            'position' => $validated['position'] ?? null,
            'phone_number' => $validated['phone_number'] ?? null,
        ]);

        // Assign system access
        if (!empty($validated['system_ids'])) {
            $user->systems()->sync($validated['system_ids']);
        }

        $user->load(['branch', 'systems']);

        AuditLog::create([
            'user_id' => $request->user()->id,
            'action' => 'create_user',
            'ip_address' => $request->ip(),
            'user_agent' => $request->userAgent(),
            'metadata' => ['created_user_id' => $user->id],
        ]);

        return response()->json([
            'success' => true,
            'message' => 'User created successfully.',
            'data' => $this->formatUser($user),
        ], 201);
    }

    /**
     * Show a single user.
     */
    public function show(User $user): JsonResponse
    {
        $user->load(['branch', 'systems']);

        return response()->json([
            'success' => true,
            'data' => $this->formatUser($user),
        ]);
    }

    /**
     * Update a user.
     */
    public function update(Request $request, User $user): JsonResponse
    {
        $validated = $request->validate([
            'name' => ['sometimes', 'string', 'max:255'],
            'username' => ['sometimes', 'string', 'max:255', 'alpha_dash', 'unique:users,username,' . $user->id],
            'email' => ['sometimes', 'string', 'email', 'max:255', 'unique:users,email,' . $user->id],
            'password' => ['sometimes', 'confirmed', Password::min(8)->mixedCase()->numbers()->symbols()],
            'role' => ['sometimes', 'string', 'in:admin,user'],
            'is_active' => ['sometimes', 'boolean'],
            'branch_id' => ['nullable', 'integer', 'exists:branches,id'],
            'employee_id' => ['nullable', 'string', 'max:100', 'unique:users,employee_id,' . $user->id],
            'department' => ['nullable', 'string', 'max:255'],
            'position' => ['nullable', 'string', 'max:255'],
            'phone_number' => ['nullable', 'string', 'max:50'],
            'system_ids' => ['sometimes', 'array'],
            'system_ids.*' => ['integer', 'exists:systems,id'],
        ], [
            'username.unique' => 'This username is already taken.',
            'username.alpha_dash' => 'Username may only contain letters, numbers, dashes and underscores.',
            'email.unique' => 'This email is already registered.',
            'password.confirmed' => 'Password confirmation does not match.',
            'employee_id.unique' => 'This employee ID is already assigned.',
        ]);

        // Extract system_ids before updating user fields
        $systemIds = $validated['system_ids'] ?? null;
        unset($validated['system_ids']);

        $user->update($validated);

        // Sync system access if provided
        if ($systemIds !== null) {
            $user->systems()->sync($systemIds);
        }

        $user->load(['branch', 'systems']);

        AuditLog::create([
            'user_id' => $request->user()->id,
            'action' => 'update_user',
            'ip_address' => $request->ip(),
            'user_agent' => $request->userAgent(),
            'metadata' => ['updated_user_id' => $user->id, 'fields' => array_keys($validated)],
        ]);

        return response()->json([
            'success' => true,
            'message' => 'User updated successfully.',
            'data' => $this->formatUser($user),
        ]);
    }

    /**
     * Delete a user.
     */
    public function destroy(Request $request, User $user): JsonResponse
    {
        if ($request->user()->id === $user->id) {
            return response()->json([
                'success' => false,
                'message' => 'You cannot delete your own account.',
            ], 403);
        }

        AuditLog::create([
            'user_id' => $request->user()->id,
            'action' => 'delete_user',
            'ip_address' => $request->ip(),
            'user_agent' => $request->userAgent(),
            'metadata' => ['deleted_user_id' => $user->id, 'deleted_email' => $user->email],
        ]);

        $user->tokens()->delete();
        $user->delete();

        return response()->json([
            'success' => true,
            'message' => 'User deleted successfully.',
        ]);
    }

    /**
     * Toggle user active/inactive status.
     */
    public function toggleStatus(Request $request, User $user): JsonResponse
    {
        if ($request->user()->id === $user->id) {
            return response()->json([
                'success' => false,
                'message' => 'You cannot deactivate your own account.',
            ], 403);
        }

        $user->update(['is_active' => !$user->is_active]);

        if (!$user->is_active) {
            $user->tokens()->delete();
        }

        $status = $user->is_active ? 'activated' : 'deactivated';

        AuditLog::create([
            'user_id' => $request->user()->id,
            'action' => "user_{$status}",
            'ip_address' => $request->ip(),
            'user_agent' => $request->userAgent(),
            'metadata' => ['target_user_id' => $user->id],
        ]);

        return response()->json([
            'success' => true,
            'message' => "User {$status} successfully.",
            'data' => [
                'id' => $user->id,
                'is_active' => $user->is_active,
            ],
        ]);
    }

    /**
     * Admin reset user password.
     */
    public function resetPassword(Request $request, User $user): JsonResponse
    {
        $validated = $request->validate([
            'password' => ['required', 'confirmed', Password::min(8)->mixedCase()->numbers()->symbols()],
        ]);

        $user->update(['password' => $validated['password']]);
        $user->tokens()->delete();

        AuditLog::create([
            'user_id' => $request->user()->id,
            'action' => 'admin_reset_password',
            'ip_address' => $request->ip(),
            'user_agent' => $request->userAgent(),
            'metadata' => ['target_user_id' => $user->id],
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Password reset successfully.',
        ]);
    }

    /**
     * Configure system access for a user (with per-system roles).
     *
     * Accepts: { "systems": [ { "id": 1, "role": "admin" }, { "id": 3, "role": "cashier" } ] }
     */
    public function configureAccess(Request $request, User $user): JsonResponse
    {
        $validated = $request->validate([
            'systems' => ['present', 'array'],
            'systems.*.id' => ['required', 'integer', 'exists:systems,id'],
            'systems.*.role' => ['required', 'string', 'max:50'],
        ]);

        // Build sync data: [ system_id => ['role' => 'x'] ]
        $syncData = [];
        foreach ($validated['systems'] as $entry) {
            $syncData[$entry['id']] = [
                'role' => $entry['role'],
                'is_active' => true,
                'granted_at' => now(),
            ];
        }

        $user->systems()->sync($syncData);
        $user->load('systems');

        AuditLog::create([
            'user_id' => $request->user()->id,
            'action' => 'configure_access',
            'ip_address' => $request->ip(),
            'user_agent' => $request->userAgent(),
            'metadata' => [
                'target_user_id' => $user->id,
                'systems' => $validated['systems'],
            ],
        ]);

        return response()->json([
            'success' => true,
            'message' => 'System access configured successfully.',
            'data' => $this->formatUser($user),
        ]);
    }
}
