<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->foreignId('branch_id')->nullable()->after('is_active')->constrained('branches')->nullOnDelete();
            $table->string('employee_id')->nullable()->unique()->after('branch_id');
            $table->string('department')->nullable()->after('employee_id');
            $table->string('position')->nullable()->after('department');
            $table->string('phone_number')->nullable()->after('position');
        });
    }

    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropForeign(['branch_id']);
            $table->dropColumn(['branch_id', 'employee_id', 'department', 'position', 'phone_number']);
        });
    }
};
