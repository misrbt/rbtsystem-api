<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('branches', function (Blueprint $table) {
            $table->id();
            $table->string('branch_name');
            $table->string('brak');
            $table->string('brcode')->unique();
            $table->foreignId('parent_id')->nullable()->constrained('branches')->nullOnDelete();
            $table->boolean('is_active')->default(true);
            $table->timestamps();

            $table->index('brak');
            $table->index('branch_name');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('branches');
    }
};
