<?php

namespace Database\Seeders;

use App\Models\Branch;
use App\Models\System;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        // Seed branches first
        $this->call(BranchSeeder::class);

        // Get Head Office branch for admin
        $headOffice = Branch::where('brcode', '00')->first();

        // Create default admin user
        $admin = User::create([
            'name' => 'Super Admin',
            'username' => 'admin',
            'email' => 'admin@rbtbank.com',
            'password' => 'Admin@1234',
            'role' => 'admin',
            'is_active' => true,
            'email_verified_at' => now(),
            'branch_id' => $headOffice?->id,
            'department' => 'IT',
            'position' => 'MIS',
        ]);

        // Register all 5 client systems
        $systems = [
            [
                'name' => 'MIS System',
                'slug' => 'mis_system',
                'description' => 'Management Information System',
                'base_url' => 'http://localhost:5173',
            ],
            [
                'name' => 'AMLA Report',
                'slug' => 'amla_report',
                'description' => 'Anti-Money Laundering Act Reporting System',
                'base_url' => null,
            ],
            [
                'name' => 'Risk Profiling',
                'slug' => 'risk_profiling',
                'description' => 'Customer Risk Profiling System',
                'base_url' => null,
            ],
            [
                'name' => 'Sigcard',
                'slug' => 'sigcard',
                'description' => 'Signature Card Management System',
                'base_url' => null,
            ],
            [
                'name' => 'GRC System',
                'slug' => 'grc_system',
                'description' => 'Governance, Risk & Compliance System',
                'base_url' => null,
            ],
        ];

        foreach ($systems as $systemData) {
            $system = System::create([
                ...$systemData,
                'is_active' => true,
                'api_key' => Str::random(64),
            ]);

            // Grant admin access to all systems with admin role
            $admin->systems()->attach($system->id, ['role' => 'admin']);
        }

        // Seed all per-system permissions
        $this->call(SystemPermissionSeeder::class);

        $this->command->info('Default admin user created: admin@rbtbank.com / Admin@1234');
        $this->command->info('5 client systems registered with permissions.');
    }
}
