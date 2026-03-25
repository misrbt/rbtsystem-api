<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('systems', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('slug')->unique();
            $table->text('description')->nullable();
            $table->string('base_url')->nullable();
            $table->boolean('is_active')->default(true);
            $table->string('api_key', 64)->unique();
            $table->timestamps();
        });

        Schema::create('system_user', function (Blueprint $table) {
            $table->id();
            $table->foreignId('system_id')->constrained()->cascadeOnDelete();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->boolean('is_active')->default(true);
            $table->timestamp('granted_at')->useCurrent();
            $table->unique(['system_id', 'user_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('system_user');
        Schema::dropIfExists('systems');
    }
};
