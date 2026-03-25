<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\System;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class SystemController extends Controller
{
    public function index(): JsonResponse
    {
        $systems = System::all()->map(function ($system) {
            return [
                'id' => $system->id,
                'name' => $system->name,
                'slug' => $system->slug,
                'description' => $system->description,
                'base_url' => $system->base_url,
                'is_active' => $system->is_active,
                'available_roles' => System::rolesForSystem($system->slug),
                'created_at' => $system->created_at,
            ];
        });

        return response()->json([
            'success' => true,
            'data' => $systems,
        ]);
    }

    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'slug' => ['required', 'string', 'max:100', 'unique:systems', 'alpha_dash'],
            'description' => ['nullable', 'string'],
            'base_url' => ['nullable', 'string', 'url:http,https'],
        ]);

        $system = System::create([
            ...$validated,
            'is_active' => true,
            'api_key' => Str::random(64),
        ]);

        return response()->json([
            'success' => true,
            'message' => 'System registered successfully.',
            'data' => [
                'id' => $system->id,
                'name' => $system->name,
                'slug' => $system->slug,
                'description' => $system->description,
                'base_url' => $system->base_url,
                'is_active' => $system->is_active,
                'api_key' => $system->api_key,
                'created_at' => $system->created_at,
            ],
        ], 201);
    }

    public function show(System $system): JsonResponse
    {
        return response()->json([
            'success' => true,
            'data' => [
                'id' => $system->id,
                'name' => $system->name,
                'slug' => $system->slug,
                'description' => $system->description,
                'base_url' => $system->base_url,
                'is_active' => $system->is_active,
                'users_count' => $system->users()->count(),
                'created_at' => $system->created_at,
            ],
        ]);
    }

    public function update(Request $request, System $system): JsonResponse
    {
        $validated = $request->validate([
            'name' => ['sometimes', 'string', 'max:255'],
            'slug' => ['sometimes', 'string', 'max:100', 'alpha_dash', 'unique:systems,slug,' . $system->id],
            'description' => ['nullable', 'string'],
            'base_url' => ['nullable', 'string', 'url:http,https'],
            'is_active' => ['sometimes', 'boolean'],
        ]);

        $system->update($validated);

        return response()->json([
            'success' => true,
            'message' => 'System updated successfully.',
            'data' => [
                'id' => $system->id,
                'name' => $system->name,
                'slug' => $system->slug,
                'description' => $system->description,
                'base_url' => $system->base_url,
                'is_active' => $system->is_active,
            ],
        ]);
    }

    public function regenerateApiKey(System $system): JsonResponse
    {
        $system->update(['api_key' => Str::random(64)]);

        return response()->json([
            'success' => true,
            'message' => 'API key regenerated successfully.',
            'data' => [
                'api_key' => $system->api_key,
            ],
        ]);
    }
}
