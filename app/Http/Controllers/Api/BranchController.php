<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Branch;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class BranchController extends Controller
{
    /**
     * List all branches with optional search/filter.
     */
    public function index(Request $request): JsonResponse
    {
        $query = Branch::query()->orderBy('brcode');

        if ($request->has('search')) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('branch_name', 'ilike', "%{$search}%")
                  ->orWhere('brak', 'ilike', "%{$search}%")
                  ->orWhere('brcode', 'ilike', "%{$search}%");
            });
        }

        if ($request->has('is_active')) {
            $query->where('is_active', filter_var($request->is_active, FILTER_VALIDATE_BOOLEAN));
        }

        $branches = $query->get()->map(function ($branch) {
            return [
                'id' => $branch->id,
                'branch_name' => $branch->branch_name,
                'brak' => $branch->brak,
                'brcode' => $branch->brcode,
                'parent_id' => $branch->parent_id,
                'is_active' => $branch->is_active,
                'employees_count' => $branch->users()->count(),
                'created_at' => $branch->created_at,
                'updated_at' => $branch->updated_at,
            ];
        });

        return response()->json([
            'success' => true,
            'data' => $branches,
        ]);
    }

    /**
     * Get branches formatted for dropdown/select.
     */
    public function dropdown(): JsonResponse
    {
        $branches = Branch::where('is_active', true)
            ->orderBy('brcode')
            ->get()
            ->map(function ($branch) {
                return [
                    'id' => $branch->id,
                    'branch_name' => $branch->branch_name,
                    'brak' => $branch->brak,
                    'brcode' => $branch->brcode,
                    'display_name' => $branch->display_name,
                ];
            });

        return response()->json([
            'success' => true,
            'data' => $branches,
        ]);
    }

    /**
     * Create a new branch.
     */
    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'branch_name' => ['required', 'string', 'max:255'],
            'brak' => ['required', 'string', 'max:255'],
            'brcode' => ['required', 'string', 'max:255', 'unique:branches,brcode'],
            'parent_id' => ['nullable', 'integer', 'exists:branches,id'],
        ]);

        $branch = Branch::create([
            ...$validated,
            'is_active' => true,
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Branch created successfully.',
            'data' => [
                'id' => $branch->id,
                'branch_name' => $branch->branch_name,
                'brak' => $branch->brak,
                'brcode' => $branch->brcode,
                'parent_id' => $branch->parent_id,
                'is_active' => $branch->is_active,
                'created_at' => $branch->created_at,
            ],
        ], 201);
    }

    /**
     * Show a single branch.
     */
    public function show(Branch $branch): JsonResponse
    {
        return response()->json([
            'success' => true,
            'data' => [
                'id' => $branch->id,
                'branch_name' => $branch->branch_name,
                'brak' => $branch->brak,
                'brcode' => $branch->brcode,
                'parent_id' => $branch->parent_id,
                'is_active' => $branch->is_active,
                'parent' => $branch->parent ? [
                    'id' => $branch->parent->id,
                    'branch_name' => $branch->parent->branch_name,
                ] : null,
                'children' => $branch->children->map(fn ($child) => [
                    'id' => $child->id,
                    'branch_name' => $child->branch_name,
                    'brcode' => $child->brcode,
                ]),
                'employees_count' => $branch->users()->count(),
                'created_at' => $branch->created_at,
                'updated_at' => $branch->updated_at,
            ],
        ]);
    }

    /**
     * Update a branch.
     */
    public function update(Request $request, Branch $branch): JsonResponse
    {
        $validated = $request->validate([
            'branch_name' => ['sometimes', 'string', 'max:255'],
            'brak' => ['sometimes', 'string', 'max:255'],
            'brcode' => ['sometimes', 'string', 'max:255', 'unique:branches,brcode,' . $branch->id],
            'parent_id' => ['nullable', 'integer', 'exists:branches,id'],
            'is_active' => ['sometimes', 'boolean'],
        ]);

        $branch->update($validated);

        return response()->json([
            'success' => true,
            'message' => 'Branch updated successfully.',
            'data' => [
                'id' => $branch->id,
                'branch_name' => $branch->branch_name,
                'brak' => $branch->brak,
                'brcode' => $branch->brcode,
                'parent_id' => $branch->parent_id,
                'is_active' => $branch->is_active,
                'updated_at' => $branch->updated_at,
            ],
        ]);
    }

    /**
     * Delete a branch (only if no users assigned).
     */
    public function destroy(Branch $branch): JsonResponse
    {
        if ($branch->users()->count() > 0) {
            return response()->json([
                'success' => false,
                'message' => 'Cannot delete branch with assigned employees.',
            ], 422);
        }

        if ($branch->children()->count() > 0) {
            return response()->json([
                'success' => false,
                'message' => 'Cannot delete branch with child branches. Remove child branches first.',
            ], 422);
        }

        $branch->delete();

        return response()->json([
            'success' => true,
            'message' => 'Branch deleted successfully.',
        ]);
    }

    /**
     * Get branch statistics.
     */
    public function statistics(): JsonResponse
    {
        $total = Branch::count();
        $active = Branch::where('is_active', true)->count();
        $motherBranches = Branch::whereNull('parent_id')->count();
        $liteBranches = Branch::whereNotNull('parent_id')->count();

        return response()->json([
            'success' => true,
            'data' => [
                'total_branches' => $total,
                'active_branches' => $active,
                'mother_branches' => $motherBranches,
                'lite_branches' => $liteBranches,
            ],
        ]);
    }

    /**
     * Return all branches for syncing to client system databases.
     * Public endpoint — no auth required.
     */
    public function sync(): JsonResponse
    {
        $branches = Branch::orderBy('brcode')->get()->map(fn ($b) => [
            'id' => $b->id,
            'branch_name' => $b->branch_name,
            'brak' => $b->brak,
            'brcode' => $b->brcode,
            'parent_id' => $b->parent_id,
            'is_active' => $b->is_active,
        ]);

        return response()->json([
            'success' => true,
            'data' => $branches,
        ]);
    }
}
