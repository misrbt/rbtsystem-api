<?php

namespace Database\Seeders;

use App\Models\System;
use App\Models\SystemPermission;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class SystemPermissionSeeder extends Seeder
{
    public function run(): void
    {
        $this->seedMisSystem();
        $this->seedAmlaReport();
        $this->seedRiskProfiling();
        $this->seedSigcard();
        $this->seedGrcSystem();

        $this->command->info('All system permissions seeded.');
    }

    private function seedMisSystem(): void
    {
        $system = System::where('slug', 'mis_system')->first();
        if (!$system) return;

        $permissions = [
            ['name' => 'View Dashboard', 'slug' => 'view-dashboard', 'group' => 'Dashboard'],
            ['name' => 'View Users', 'slug' => 'view-users', 'group' => 'User Management'],
            ['name' => 'Manage Users', 'slug' => 'manage-users', 'group' => 'User Management'],
            ['name' => 'View Audit Logs', 'slug' => 'view-audit-logs', 'group' => 'Audit'],
            ['name' => 'View Assets', 'slug' => 'view-assets', 'group' => 'Inventory'],
            ['name' => 'Manage Assets', 'slug' => 'manage-assets', 'group' => 'Inventory'],
            ['name' => 'View Employees', 'slug' => 'view-employees', 'group' => 'Employees'],
            ['name' => 'Manage Employees', 'slug' => 'manage-employees', 'group' => 'Employees'],
            ['name' => 'View Reports', 'slug' => 'view-reports', 'group' => 'Reports'],
            ['name' => 'Export Reports', 'slug' => 'export-reports', 'group' => 'Reports'],
        ];

        $this->createPermissionsAndRoles($system, $permissions, [
            'admin' => ['view-dashboard', 'view-users', 'manage-users', 'view-audit-logs', 'view-assets', 'manage-assets', 'view-employees', 'manage-employees', 'view-reports', 'export-reports'],
            'user' => ['view-dashboard', 'view-assets', 'view-employees', 'view-reports'],
        ]);
    }

    private function seedAmlaReport(): void
    {
        $system = System::where('slug', 'amla_report')->first();
        if (!$system) return;

        $permissions = [
            ['name' => 'View Dashboard', 'slug' => 'view-dashboard', 'group' => 'Dashboard'],
            ['name' => 'View Reports', 'slug' => 'view-reports', 'group' => 'Reports'],
            ['name' => 'Create Reports', 'slug' => 'create-reports', 'group' => 'Reports'],
            ['name' => 'Edit Reports', 'slug' => 'edit-reports', 'group' => 'Reports'],
            ['name' => 'Delete Reports', 'slug' => 'delete-reports', 'group' => 'Reports'],
            ['name' => 'Submit Reports', 'slug' => 'submit-reports', 'group' => 'Reports'],
            ['name' => 'View Data Configuration', 'slug' => 'view-data-config', 'group' => 'Configuration'],
            ['name' => 'Manage Data Configuration', 'slug' => 'manage-data-config', 'group' => 'Configuration'],
            ['name' => 'View Users', 'slug' => 'view-users', 'group' => 'User Management'],
            ['name' => 'Manage Users', 'slug' => 'manage-users', 'group' => 'User Management'],
        ];

        $this->createPermissionsAndRoles($system, $permissions, [
            'admin' => ['view-dashboard', 'view-reports', 'create-reports', 'edit-reports', 'delete-reports', 'submit-reports', 'view-data-config', 'manage-data-config', 'view-users', 'manage-users'],
            'compliance' => ['view-dashboard', 'view-reports', 'create-reports', 'edit-reports', 'submit-reports', 'view-data-config'],
            'user' => ['view-dashboard', 'view-reports', 'create-reports'],
        ]);
    }

    private function seedRiskProfiling(): void
    {
        $system = System::where('slug', 'risk_profiling')->first();
        if (!$system) return;

        $permissions = [
            ['name' => 'View Users', 'slug' => 'view-users', 'group' => 'User Management'],
            ['name' => 'Manage Users', 'slug' => 'manage-users', 'group' => 'User Management'],
            ['name' => 'View Roles', 'slug' => 'view-roles', 'group' => 'Role Management'],
            ['name' => 'Manage Roles', 'slug' => 'manage-roles', 'group' => 'Role Management'],
            ['name' => 'View Permissions', 'slug' => 'view-permissions', 'group' => 'Permission Management'],
            ['name' => 'Manage Permissions', 'slug' => 'manage-permissions', 'group' => 'Permission Management'],
            ['name' => 'View Customers', 'slug' => 'view-customers', 'group' => 'Customer Management'],
            ['name' => 'Manage Customers', 'slug' => 'manage-customers', 'group' => 'Customer Management'],
            ['name' => 'View Risk Assessments', 'slug' => 'view-risk-assessments', 'group' => 'Risk Assessment'],
            ['name' => 'Create Risk Assessments', 'slug' => 'create-risk-assessments', 'group' => 'Risk Assessment'],
            ['name' => 'Edit Risk Assessments', 'slug' => 'edit-risk-assessments', 'group' => 'Risk Assessment'],
            ['name' => 'Delete Risk Assessments', 'slug' => 'delete-risk-assessments', 'group' => 'Risk Assessment'],
            ['name' => 'View Risk Settings', 'slug' => 'view-risk-settings', 'group' => 'Risk Settings'],
            ['name' => 'Manage Risk Settings', 'slug' => 'manage-risk-settings', 'group' => 'Risk Settings'],
            ['name' => 'View Basic Dashboard', 'slug' => 'view-basic-dashboard', 'group' => 'Dashboard'],
            ['name' => 'View Admin Dashboard', 'slug' => 'view-admin-dashboard', 'group' => 'Dashboard'],
            ['name' => 'View Branch Analytics', 'slug' => 'view-branch-analytics', 'group' => 'Dashboard'],
            ['name' => 'View System Analytics', 'slug' => 'view-system-analytics', 'group' => 'Dashboard'],
            ['name' => 'View Basic Reports', 'slug' => 'view-basic-reports', 'group' => 'Reports'],
            ['name' => 'View Advanced Reports', 'slug' => 'view-advanced-reports', 'group' => 'Reports'],
            ['name' => 'Export Reports', 'slug' => 'export-reports', 'group' => 'Reports'],
            ['name' => 'View System Settings', 'slug' => 'view-system-settings', 'group' => 'System Settings'],
            ['name' => 'Manage System Settings', 'slug' => 'manage-system-settings', 'group' => 'System Settings'],
            ['name' => 'View Audit Logs', 'slug' => 'view-audit-logs', 'group' => 'Audit'],
            ['name' => 'Manage Audit Logs', 'slug' => 'manage-audit-logs', 'group' => 'Audit'],
            ['name' => 'View Branches', 'slug' => 'view-branches', 'group' => 'Branch Management'],
            ['name' => 'Manage Branches', 'slug' => 'manage-branches', 'group' => 'Branch Management'],
        ];

        $this->createPermissionsAndRoles($system, $permissions, [
            'admin' => array_column($permissions, 'slug'), // All permissions
            'manager' => ['view-users', 'view-roles', 'view-permissions', 'view-customers', 'manage-customers', 'view-risk-assessments', 'edit-risk-assessments', 'view-basic-dashboard', 'view-branch-analytics', 'view-basic-reports', 'view-branches'],
            'compliance' => ['view-users', 'view-roles', 'view-permissions', 'view-customers', 'manage-customers', 'view-risk-assessments', 'edit-risk-assessments', 'view-risk-settings', 'manage-risk-settings', 'view-basic-dashboard', 'view-branch-analytics', 'view-advanced-reports', 'export-reports', 'view-audit-logs', 'view-branches'],
            'audit' => ['view-users', 'view-customers', 'view-risk-assessments', 'view-basic-dashboard', 'view-branch-analytics', 'view-basic-reports', 'view-advanced-reports', 'view-audit-logs', 'view-branches'],
            'user' => ['view-customers', 'view-risk-assessments', 'create-risk-assessments', 'edit-risk-assessments'],
        ]);
    }

    private function seedSigcard(): void
    {
        $system = System::where('slug', 'sigcard')->first();
        if (!$system) return;

        $permissions = [
            // User Management
            ['name' => 'View Users', 'slug' => 'view-users', 'group' => 'User Management'],
            ['name' => 'Create Users', 'slug' => 'create-users', 'group' => 'User Management'],
            ['name' => 'Edit Users', 'slug' => 'edit-users', 'group' => 'User Management'],
            ['name' => 'Delete Users', 'slug' => 'delete-users', 'group' => 'User Management'],
            ['name' => 'Activate Users', 'slug' => 'activate-users', 'group' => 'User Management'],
            ['name' => 'Deactivate Users', 'slug' => 'deactivate-users', 'group' => 'User Management'],
            ['name' => 'Reset User Passwords', 'slug' => 'reset-user-passwords', 'group' => 'User Management'],
            ['name' => 'Unlock User Accounts', 'slug' => 'unlock-user-accounts', 'group' => 'User Management'],
            // Role & Permission
            ['name' => 'View Roles', 'slug' => 'view-roles', 'group' => 'Role Management'],
            ['name' => 'Create Roles', 'slug' => 'create-roles', 'group' => 'Role Management'],
            ['name' => 'Edit Roles', 'slug' => 'edit-roles', 'group' => 'Role Management'],
            ['name' => 'Delete Roles', 'slug' => 'delete-roles', 'group' => 'Role Management'],
            ['name' => 'Assign Roles', 'slug' => 'assign-roles', 'group' => 'Role Management'],
            ['name' => 'View Permissions', 'slug' => 'view-permissions', 'group' => 'Permission Management'],
            ['name' => 'Assign Permissions', 'slug' => 'assign-permissions', 'group' => 'Permission Management'],
            // Transactions
            ['name' => 'View Transactions', 'slug' => 'view-transactions', 'group' => 'Transactions'],
            ['name' => 'Create Transactions', 'slug' => 'create-transactions', 'group' => 'Transactions'],
            ['name' => 'Edit Transactions', 'slug' => 'edit-transactions', 'group' => 'Transactions'],
            ['name' => 'Approve Transactions', 'slug' => 'approve-transactions', 'group' => 'Transactions'],
            ['name' => 'Reject Transactions', 'slug' => 'reject-transactions', 'group' => 'Transactions'],
            ['name' => 'Cancel Transactions', 'slug' => 'cancel-transactions', 'group' => 'Transactions'],
            ['name' => 'View Transaction History', 'slug' => 'view-transaction-history', 'group' => 'Transactions'],
            // Accounts
            ['name' => 'View Accounts', 'slug' => 'view-accounts', 'group' => 'Accounts'],
            ['name' => 'Create Accounts', 'slug' => 'create-accounts', 'group' => 'Accounts'],
            ['name' => 'Edit Accounts', 'slug' => 'edit-accounts', 'group' => 'Accounts'],
            ['name' => 'Close Accounts', 'slug' => 'close-accounts', 'group' => 'Accounts'],
            ['name' => 'Transfer Funds', 'slug' => 'transfer-funds', 'group' => 'Accounts'],
            ['name' => 'Approve Transfers', 'slug' => 'approve-transfers', 'group' => 'Accounts'],
            ['name' => 'View Balances', 'slug' => 'view-balances', 'group' => 'Accounts'],
            ['name' => 'Generate Statements', 'slug' => 'generate-statements', 'group' => 'Accounts'],
            // Audit & Compliance
            ['name' => 'View Audit Logs', 'slug' => 'view-audit-logs', 'group' => 'Audit & Compliance'],
            ['name' => 'Export Audit Logs', 'slug' => 'export-audit-logs', 'group' => 'Audit & Compliance'],
            ['name' => 'View Compliance Reports', 'slug' => 'view-compliance-reports', 'group' => 'Audit & Compliance'],
            ['name' => 'Generate Compliance Reports', 'slug' => 'generate-compliance-reports', 'group' => 'Audit & Compliance'],
            ['name' => 'View Risk Assessments', 'slug' => 'view-risk-assessments', 'group' => 'Audit & Compliance'],
            ['name' => 'Create Risk Assessments', 'slug' => 'create-risk-assessments', 'group' => 'Audit & Compliance'],
            ['name' => 'Approve Risk Assessments', 'slug' => 'approve-risk-assessments', 'group' => 'Audit & Compliance'],
            // System
            ['name' => 'View System Settings', 'slug' => 'view-system-settings', 'group' => 'System'],
            ['name' => 'Edit System Settings', 'slug' => 'edit-system-settings', 'group' => 'System'],
            ['name' => 'View System Logs', 'slug' => 'view-system-logs', 'group' => 'System'],
            ['name' => 'Backup System', 'slug' => 'backup-system', 'group' => 'System'],
            ['name' => 'Restore System', 'slug' => 'restore-system', 'group' => 'System'],
            ['name' => 'Manage Security Policies', 'slug' => 'manage-security-policies', 'group' => 'System'],
            // Customers
            ['name' => 'View Customers', 'slug' => 'view-customers', 'group' => 'Customers'],
            ['name' => 'Create Customers', 'slug' => 'create-customers', 'group' => 'Customers'],
            ['name' => 'Edit Customers', 'slug' => 'edit-customers', 'group' => 'Customers'],
            ['name' => 'Verify Customers', 'slug' => 'verify-customers', 'group' => 'Customers'],
            ['name' => 'Suspend Customers', 'slug' => 'suspend-customers', 'group' => 'Customers'],
            ['name' => 'View Customer Documents', 'slug' => 'view-customer-documents', 'group' => 'Customers'],
            ['name' => 'Approve Customer Applications', 'slug' => 'approve-customer-applications', 'group' => 'Customers'],
            // Reports
            ['name' => 'View Reports', 'slug' => 'view-reports', 'group' => 'Reports'],
            ['name' => 'Generate Reports', 'slug' => 'generate-reports', 'group' => 'Reports'],
            ['name' => 'Export Reports', 'slug' => 'export-reports', 'group' => 'Reports'],
            ['name' => 'View Financial Reports', 'slug' => 'view-financial-reports', 'group' => 'Reports'],
            ['name' => 'View Regulatory Reports', 'slug' => 'view-regulatory-reports', 'group' => 'Reports'],
            // Security
            ['name' => 'Force Password Reset', 'slug' => 'force-password-reset', 'group' => 'Security'],
            ['name' => 'Unlock Accounts', 'slug' => 'unlock-accounts', 'group' => 'Security'],
            ['name' => 'View Login Attempts', 'slug' => 'view-login-attempts', 'group' => 'Security'],
            ['name' => 'Manage Sessions', 'slug' => 'manage-sessions', 'group' => 'Security'],
            ['name' => 'Enable/Disable 2FA', 'slug' => 'enable-disable-2fa', 'group' => 'Security'],
            // Branch
            ['name' => 'View Branch Data', 'slug' => 'view-branch-data', 'group' => 'Branch Operations'],
            ['name' => 'Manage Branch Operations', 'slug' => 'manage-branch-operations', 'group' => 'Branch Operations'],
            ['name' => 'View Branch Reports', 'slug' => 'view-branch-reports', 'group' => 'Branch Operations'],
            ['name' => 'Approve Branch Transactions', 'slug' => 'approve-branch-transactions', 'group' => 'Branch Operations'],
        ];

        $allSlugs = array_column($permissions, 'slug');

        $this->createPermissionsAndRoles($system, $permissions, [
            'admin' => $allSlugs,
            'manager' => ['view-users', 'edit-users', 'activate-users', 'deactivate-users', 'reset-user-passwords', 'unlock-user-accounts', 'view-transactions', 'approve-transactions', 'reject-transactions', 'view-transaction-history', 'view-accounts', 'view-balances', 'approve-transfers', 'generate-statements', 'view-customers', 'edit-customers', 'verify-customers', 'approve-customer-applications', 'view-reports', 'generate-reports', 'export-reports', 'view-financial-reports', 'view-audit-logs', 'view-compliance-reports', 'view-risk-assessments', 'approve-risk-assessments', 'view-branch-data', 'manage-branch-operations', 'view-branch-reports', 'approve-branch-transactions'],
            'cashier' => ['view-transactions', 'view-transaction-history', 'view-accounts', 'view-balances', 'view-customers', 'view-customer-documents', 'view-branch-data'],
            'compliance-audit' => ['view-audit-logs', 'export-audit-logs', 'view-compliance-reports', 'generate-compliance-reports', 'view-risk-assessments', 'create-risk-assessments', 'view-users', 'view-transactions', 'view-transaction-history', 'view-accounts', 'view-customers', 'view-reports', 'generate-reports', 'export-reports', 'view-financial-reports', 'view-regulatory-reports', 'view-login-attempts', 'view-system-logs', 'view-branch-data', 'view-branch-reports'],
            'user' => ['view-transactions', 'create-transactions', 'view-transaction-history', 'view-accounts', 'view-balances', 'generate-statements', 'view-customers', 'edit-customers', 'view-customer-documents', 'view-reports', 'generate-reports'],
        ]);
    }

    private function seedGrcSystem(): void
    {
        $system = System::where('slug', 'grc_system')->first();
        if (!$system) return;

        $permissions = [
            // Dashboard
            ['name' => 'View Dashboard', 'slug' => 'view-dashboard', 'group' => 'Dashboard'],
            // Risk Management
            ['name' => 'View Risks', 'slug' => 'view-risks', 'group' => 'Risk Management'],
            ['name' => 'Create Risks', 'slug' => 'create-risks', 'group' => 'Risk Management'],
            ['name' => 'Edit Risks', 'slug' => 'edit-risks', 'group' => 'Risk Management'],
            ['name' => 'Delete Risks', 'slug' => 'delete-risks', 'group' => 'Risk Management'],
            // Controls
            ['name' => 'View Controls', 'slug' => 'view-controls', 'group' => 'Controls'],
            ['name' => 'Manage Controls', 'slug' => 'manage-controls', 'group' => 'Controls'],
            // Compliance (only compliance + admin)
            ['name' => 'View Compliance', 'slug' => 'view-compliance', 'group' => 'Compliance'],
            ['name' => 'Manage Compliance', 'slug' => 'manage-compliance', 'group' => 'Compliance'],
            ['name' => 'View Compliance Reports', 'slug' => 'view-compliance-reports', 'group' => 'Compliance'],
            ['name' => 'Generate Compliance Reports', 'slug' => 'generate-compliance-reports', 'group' => 'Compliance'],
            // Audit (audit + compliance + admin)
            ['name' => 'View Audit Logs', 'slug' => 'view-audit-logs', 'group' => 'Audit'],
            ['name' => 'Create Audit Findings', 'slug' => 'create-audit-findings', 'group' => 'Audit'],
            ['name' => 'View Audit Reports', 'slug' => 'view-audit-reports', 'group' => 'Audit'],
            ['name' => 'Export Audit Reports', 'slug' => 'export-audit-reports', 'group' => 'Audit'],
            // Reports
            ['name' => 'View Reports', 'slug' => 'view-reports', 'group' => 'Reports'],
            ['name' => 'Export Reports', 'slug' => 'export-reports', 'group' => 'Reports'],
            // User Management
            ['name' => 'View Users', 'slug' => 'view-users', 'group' => 'User Management'],
            ['name' => 'Manage Users', 'slug' => 'manage-users', 'group' => 'User Management'],
        ];

        $allSlugs = array_column($permissions, 'slug');

        $this->createPermissionsAndRoles($system, $permissions, [
            // Admin: everything
            'admin' => $allSlugs,
            // Compliance: can access compliance + audit data + risks + controls + reports
            'compliance' => [
                'view-dashboard',
                'view-risks', 'create-risks', 'edit-risks',
                'view-controls', 'manage-controls',
                'view-compliance', 'manage-compliance', 'view-compliance-reports', 'generate-compliance-reports',
                'view-audit-logs', 'view-audit-reports', 'export-audit-reports', // CAN see audit
                'view-reports', 'export-reports',
                'view-users',
            ],
            // Audit: can access audit data + risks + controls, but NOT compliance
            'audit' => [
                'view-dashboard',
                'view-risks',
                'view-controls',
                'view-audit-logs', 'create-audit-findings', 'view-audit-reports', 'export-audit-reports',
                'view-reports',
            ],
            // User: basic read-only
            'user' => [
                'view-dashboard',
                'view-risks',
                'view-controls',
                'view-reports',
            ],
        ]);
    }

    private function createPermissionsAndRoles(System $system, array $permissions, array $rolePermissions): void
    {
        // Create permissions
        $permMap = [];
        foreach ($permissions as $perm) {
            $p = SystemPermission::firstOrCreate(
                ['system_id' => $system->id, 'slug' => $perm['slug']],
                ['name' => $perm['name'], 'group' => $perm['group']]
            );
            $permMap[$perm['slug']] = $p->id;
        }

        // Map role → permissions
        foreach ($rolePermissions as $role => $slugs) {
            foreach ($slugs as $slug) {
                if (isset($permMap[$slug])) {
                    DB::table('system_role_permissions')->insertOrIgnore([
                        'system_id' => $system->id,
                        'role' => $role,
                        'permission_id' => $permMap[$slug],
                    ]);
                }
            }
        }
    }
}
