<?php

use App\Http\Middleware\CheckSystemApiKey;
use App\Http\Middleware\ForceJsonResponse;
use App\Http\Middleware\SecurityHeaders;
use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        api: __DIR__.'/../routes/api.php',
        web: __DIR__.'/../routes/web.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware): void {
        $middleware->api(prepend: [
            ForceJsonResponse::class,
            SecurityHeaders::class,
        ]);

        $middleware->alias([
            'system.api_key' => CheckSystemApiKey::class,
        ]);

        // No statefulApi() — this is a pure token-based API, no CSRF needed
    })
    ->withExceptions(function (Exceptions $exceptions): void {
        //
    })->create();
