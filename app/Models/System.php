<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class System extends Model
{
    protected $fillable = [
        'name',
        'slug',
        'description',
        'base_url',
        'is_active',
        'api_key',
    ];

    protected $hidden = [
        'api_key',
    ];

    protected function casts(): array
    {
        return [
            'is_active' => 'boolean',
        ];
    }

    public function users()
    {
        return $this->belongsToMany(User::class, 'system_user')
            ->withPivot('role', 'is_active', 'granted_at');
    }

    /**
     * Available roles per system.
     */
    public static function rolesForSystem(string $slug): array
    {
        return match ($slug) {
            'mis_system' => [
                ['value' => 'admin', 'label' => 'Admin'],
                ['value' => 'user', 'label' => 'User'],
            ],
            'amla_report' => [
                ['value' => 'admin', 'label' => 'Admin'],
                ['value' => 'compliance', 'label' => 'Compliance Officer'],
                ['value' => 'user', 'label' => 'User'],
            ],
            'risk_profiling' => [
                ['value' => 'admin', 'label' => 'Admin'],
                ['value' => 'manager', 'label' => 'Manager'],
                ['value' => 'compliance', 'label' => 'Compliance Officer'],
                ['value' => 'audit', 'label' => 'Auditor'],
                ['value' => 'user', 'label' => 'User'],
            ],
            'sigcard' => [
                ['value' => 'admin', 'label' => 'Admin'],
                ['value' => 'manager', 'label' => 'Manager'],
                ['value' => 'cashier', 'label' => 'Cashier'],
                ['value' => 'compliance-audit', 'label' => 'Compliance Audit'],
                ['value' => 'user', 'label' => 'User'],
            ],
            'grc_system' => [
                ['value' => 'admin', 'label' => 'Admin'],
                ['value' => 'compliance', 'label' => 'Compliance'],
                ['value' => 'audit', 'label' => 'Audit'],
                ['value' => 'user', 'label' => 'User'],
            ],
            default => [
                ['value' => 'admin', 'label' => 'Admin'],
                ['value' => 'user', 'label' => 'User'],
            ],
        };
    }
}
