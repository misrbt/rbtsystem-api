<?php

namespace App\Http\Middleware;

use App\Models\System;
use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class CheckSystemApiKey
{
    public function handle(Request $request, Closure $next): Response
    {
        $apiKey = $request->header('X-System-Key');

        if (!$apiKey) {
            return response()->json([
                'success' => false,
                'message' => 'System API key is required.',
            ], 401);
        }

        $system = System::where('api_key', $apiKey)->where('is_active', true)->first();

        if (!$system) {
            return response()->json([
                'success' => false,
                'message' => 'Invalid or inactive system API key.',
            ], 401);
        }

        $request->merge(['_system' => $system]);

        return $next($request);
    }
}
