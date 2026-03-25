<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // Permission definitions per system
        Schema::create('system_permissions', function (Blueprint $table) {
            $table->id();
            $table->foreignId('system_id')->constrained()->cascadeOnDelete();
            $table->string('name');        // Display name: "View Users"
            $table->string('slug');        // Machine name: "view-users"
            $table->string('group')->nullable(); // Grouping: "User Management", "Customers", etc.
            $table->unique(['system_id', 'slug']);
            $table->timestamps();
        });

        // Which permissions each role gets per system
        Schema::create('system_role_permissions', function (Blueprint $table) {
            $table->id();
            $table->foreignId('system_id')->constrained()->cascadeOnDelete();
            $table->string('role');         // "admin", "manager", "cashier", etc.
            $table->foreignId('permission_id')->constrained('system_permissions')->cascadeOnDelete();
            $table->unique(['system_id', 'role', 'permission_id'], 'sys_role_perm_unique');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('system_role_permissions');
        Schema::dropIfExists('system_permissions');
    }
};
