<?php

use App\Http\Controllers\Api\AuditLogController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\BranchController;
use App\Http\Controllers\Api\SystemController;
use App\Http\Controllers\Api\UserController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Public Auth Routes (rate limited: 5 requests/min)
|--------------------------------------------------------------------------
*/
Route::prefix('auth')->middleware('throttle:5,1')->group(function () {
    Route::post('/register', [AuthController::class, 'register']);
    Route::post('/login', [AuthController::class, 'login']);
});

// Public endpoints (no auth needed — for system sync)
Route::get('/branches/sync', [BranchController::class, 'sync']);

/*
|--------------------------------------------------------------------------
| Protected Auth Routes (requires Bearer token)
|--------------------------------------------------------------------------
*/
Route::middleware('auth:sanctum')->group(function () {

    // Auth management
    Route::prefix('auth')->group(function () {
        Route::post('/logout', [AuthController::class, 'logout']);
        Route::post('/logout-all', [AuthController::class, 'logoutAll']);
        Route::get('/profile', [AuthController::class, 'profile']);
        Route::post('/refresh', [AuthController::class, 'refresh']);
        Route::put('/change-password', [AuthController::class, 'changePassword']);
        Route::get('/validate-token', [AuthController::class, 'validateToken']);
    });

    // User management (CRUD)
    Route::get('/users', [UserController::class, 'index']);
    Route::post('/users', [UserController::class, 'store']);
    Route::get('/users/{user}', [UserController::class, 'show']);
    Route::put('/users/{user}', [UserController::class, 'update']);
    Route::delete('/users/{user}', [UserController::class, 'destroy']);
    Route::patch('/users/{user}/toggle-status', [UserController::class, 'toggleStatus']);
    Route::post('/users/{user}/reset-password', [UserController::class, 'resetPassword']);
    Route::post('/users/{user}/systems', [UserController::class, 'assignSystems']);
    Route::put('/users/{user}/access', [UserController::class, 'configureAccess']);

    // System management (admin)
    Route::get('/systems', [SystemController::class, 'index']);
    Route::post('/systems', [SystemController::class, 'store']);
    Route::get('/systems/{system}', [SystemController::class, 'show']);
    Route::put('/systems/{system}', [SystemController::class, 'update']);
    Route::post('/systems/{system}/regenerate-key', [SystemController::class, 'regenerateApiKey']);

    // Branch management (CRUD)
    Route::get('/branches', [BranchController::class, 'index']);
    Route::get('/branches/dropdown', [BranchController::class, 'dropdown']);
    Route::get('/branches/statistics', [BranchController::class, 'statistics']);
    Route::post('/branches', [BranchController::class, 'store']);
    Route::get('/branches/{branch}', [BranchController::class, 'show']);
    Route::put('/branches/{branch}', [BranchController::class, 'update']);
    Route::delete('/branches/{branch}', [BranchController::class, 'destroy']);

    // Audit logs
    Route::get('/audit-logs', [AuditLogController::class, 'index']);
});

/*
|--------------------------------------------------------------------------
| System-to-System Routes (requires X-System-Key header)
|--------------------------------------------------------------------------
*/
Route::prefix('system')->middleware('system.api_key')->group(function () {
    Route::post('/validate-token', [AuthController::class, 'validateToken'])
        ->middleware('auth:sanctum');

    Route::get('/check-access/{user}', function (\App\Models\User $user, \Illuminate\Http\Request $request) {
        $system = $request->_system;
        return response()->json([
            'has_access' => $user->hasSystemAccess($system->slug),
            'user' => [
                'id' => $user->id,
                'name' => $user->name,
                'email' => $user->email,
                'role' => $user->role,
                'is_active' => $user->is_active,
            ],
        ]);
    });
});
