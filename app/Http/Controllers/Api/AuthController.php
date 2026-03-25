<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\AuditLog;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules\Password;

class AuthController extends Controller
{
    /**
     * Register a new user.
     */
    public function register(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'username' => ['required', 'string', 'max:255', 'unique:users', 'alpha_dash'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:users'],
            'password' => ['required', 'confirmed', Password::min(8)->mixedCase()->numbers()->symbols()],
        ], [
            'username.unique' => 'This username is already taken.',
            'username.alpha_dash' => 'Username may only contain letters, numbers, dashes and underscores.',
            'email.unique' => 'This email is already registered.',
            'password.confirmed' => 'Password confirmation does not match.',
        ]);

        $user = User::create([
            'name' => $validated['name'],
            'username' => $validated['username'],
            'email' => $validated['email'],
            'password' => $validated['password'],
            'role' => 'user',
            'is_active' => true,
        ]);

        $token = $user->createToken('auth_token', ['*'], now()->addMinutes(
            (int) config('sanctum.expiration', 10080)
        ))->plainTextToken;

        AuditLog::create([
            'user_id' => $user->id,
            'action' => 'register',
            'ip_address' => $request->ip(),
            'user_agent' => $request->userAgent(),
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Registration successful.',
            'data' => [
                'user' => [
                    'id' => $user->id,
                    'name' => $user->name,
                    'username' => $user->username,
                    'email' => $user->email,
                ],
                'token' => $token,
                'token_type' => 'Bearer',
            ],
        ], 201);
    }

    /**
     * Login user (supports email or username).
     */
    public function login(Request $request): JsonResponse
    {
        $request->validate([
            'login' => ['required', 'string'],
            'password' => ['required', 'string'],
            'system_slug' => ['sometimes', 'string'],
        ]);

        $loginField = filter_var($request->login, FILTER_VALIDATE_EMAIL) ? 'email' : 'username';
        $credentials = [
            $loginField => $request->login,
            'password' => $request->password,
        ];

        if (!Auth::attempt($credentials)) {
            AuditLog::create([
                'action' => 'failed_login',
                'ip_address' => $request->ip(),
                'user_agent' => $request->userAgent(),
                'metadata' => ['login' => $request->login],
            ]);

            return response()->json([
                'success' => false,
                'message' => 'The provided credentials do not match our records.',
            ], 401);
        }

        $user = Auth::user();

        if (!$user->is_active) {
            Auth::logout();
            return response()->json([
                'success' => false,
                'message' => 'Your account has been deactivated. Please contact an administrator.',
            ], 403);
        }

        // Revoke all previous tokens
        $user->tokens()->delete();

        $token = $user->createToken('auth_token', ['*'], now()->addMinutes(
            (int) config('sanctum.expiration', 10080)
        ))->plainTextToken;

        $user->load('branch');

        AuditLog::create([
            'user_id' => $user->id,
            'action' => 'login',
            'ip_address' => $request->ip(),
            'user_agent' => $request->userAgent(),
            'metadata' => $request->system_slug ? ['system' => $request->system_slug] : null,
        ]);

        // Build response data
        $responseData = [
            'user' => [
                'id' => $user->id,
                'name' => $user->name,
                'username' => $user->username,
                'email' => $user->email,
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
            ],
            'token' => $token,
            'token_type' => 'Bearer',
        ];

        // If system_slug provided, include role + permissions for that system
        if ($request->system_slug) {
            $access = $user->accessForSystem($request->system_slug);
            if ($access) {
                $responseData['access'] = $access;
            } else {
                // User has no access to this system
                $user->tokens()->delete();
                return response()->json([
                    'success' => false,
                    'message' => 'You do not have access to this system. Contact your administrator.',
                ], 403);
            }
        }

        return response()->json([
            'success' => true,
            'message' => 'Login successful.',
            'data' => $responseData,
        ]);
    }

    /**
     * Logout (revoke current token).
     */
    public function logout(Request $request): JsonResponse
    {
        AuditLog::create([
            'user_id' => $request->user()->id,
            'action' => 'logout',
            'ip_address' => $request->ip(),
            'user_agent' => $request->userAgent(),
        ]);

        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'success' => true,
            'message' => 'Logged out successfully.',
        ]);
    }

    /**
     * Logout from all devices (revoke all tokens).
     */
    public function logoutAll(Request $request): JsonResponse
    {
        AuditLog::create([
            'user_id' => $request->user()->id,
            'action' => 'logout_all',
            'ip_address' => $request->ip(),
            'user_agent' => $request->userAgent(),
        ]);

        $request->user()->tokens()->delete();

        return response()->json([
            'success' => true,
            'message' => 'Logged out from all devices successfully.',
        ]);
    }

    /**
     * Get authenticated user profile.
     */
    public function profile(Request $request): JsonResponse
    {
        $user = $request->user();
        $user->load('branch');

        return response()->json([
            'success' => true,
            'data' => [
                'user' => [
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
                    'email_verified_at' => $user->email_verified_at,
                    'created_at' => $user->created_at,
                ],
            ],
        ]);
    }

    /**
     * Refresh token (revoke old, issue new).
     */
    public function refresh(Request $request): JsonResponse
    {
        $user = $request->user();

        $request->user()->currentAccessToken()->delete();

        $token = $user->createToken('auth_token', ['*'], now()->addMinutes(
            (int) config('sanctum.expiration', 10080)
        ))->plainTextToken;

        return response()->json([
            'success' => true,
            'message' => 'Token refreshed successfully.',
            'data' => [
                'token' => $token,
                'token_type' => 'Bearer',
            ],
        ]);
    }

    /**
     * Change own password.
     */
    public function changePassword(Request $request): JsonResponse
    {
        $request->validate([
            'current_password' => ['required', 'string'],
            'password' => ['required', 'confirmed', Password::min(8)->mixedCase()->numbers()->symbols()],
        ]);

        $user = $request->user();

        if (!Hash::check($request->current_password, $user->password)) {
            return response()->json([
                'success' => false,
                'message' => 'Current password is incorrect.',
            ], 422);
        }

        $user->update(['password' => $request->password]);

        // Revoke all tokens and issue a new one
        $user->tokens()->delete();

        $token = $user->createToken('auth_token', ['*'], now()->addMinutes(
            (int) config('sanctum.expiration', 10080)
        ))->plainTextToken;

        AuditLog::create([
            'user_id' => $user->id,
            'action' => 'change_password',
            'ip_address' => $request->ip(),
            'user_agent' => $request->userAgent(),
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Password changed successfully.',
            'data' => [
                'token' => $token,
                'token_type' => 'Bearer',
            ],
        ]);
    }

    /**
     * Validate current token (used by client systems).
     */
    public function validateToken(Request $request): JsonResponse
    {
        $user = $request->user();
        $user->load('branch');

        $response = [
            'valid' => true,
            'user' => [
                'id' => $user->id,
                'name' => $user->name,
                'username' => $user->username,
                'email' => $user->email,
                'is_active' => $user->is_active,
                'branch_id' => $user->branch_id,
                'branch' => $user->branch ? [
                    'id' => $user->branch->id,
                    'branch_name' => $user->branch->branch_name,
                    'brak' => $user->branch->brak,
                    'brcode' => $user->branch->brcode,
                ] : null,
            ],
        ];

        // If system_slug provided (via query param or header), include access info
        $systemSlug = $request->query('system_slug') ?? $request->header('X-System-Slug');
        if ($systemSlug) {
            $response['access'] = $user->accessForSystem($systemSlug);
        }

        return response()->json($response);
    }
}
