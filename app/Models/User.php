<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Spatie\Permission\Traits\HasRoles;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, HasRoles, Notifiable;

    protected $fillable = [
        'name',
        'username',
        'email',
        'password',
        'role',
        'is_active',
        'branch_id',
        'employee_id',
        'department',
        'position',
        'phone_number',
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
            'is_active' => 'boolean',
        ];
    }

    public function branch()
    {
        return $this->belongsTo(Branch::class);
    }

    public function systems()
    {
        return $this->belongsToMany(System::class, 'system_user')
            ->withPivot('role', 'is_active', 'granted_at');
    }

    public function hasSystemAccess(string $systemSlug): bool
    {
        return $this->systems()
            ->where('slug', $systemSlug)
            ->wherePivot('is_active', true)
            ->where('systems.is_active', true)
            ->exists();
    }

    /**
     * Get the user's role for a specific system.
     */
    public function roleForSystem(string $systemSlug): ?string
    {
        $system = $this->systems()->where('slug', $systemSlug)->first();
        return $system?->pivot->role;
    }

    /**
     * Get all permissions for the user's role in a specific system.
     */
    public function permissionsForSystem(string $systemSlug): array
    {
        $system = $this->systems()->where('slug', $systemSlug)->first();
        if (!$system) return [];

        $role = $system->pivot->role;

        return SystemPermission::where('system_id', $system->id)
            ->whereIn('id', function ($query) use ($system, $role) {
                $query->select('permission_id')
                    ->from('system_role_permissions')
                    ->where('system_id', $system->id)
                    ->where('role', $role);
            })
            ->pluck('slug')
            ->toArray();
    }

    /**
     * Get full access info for a system (role + permissions + branch).
     */
    public function accessForSystem(string $systemSlug): ?array
    {
        $system = $this->systems()->where('slug', $systemSlug)->first();
        if (!$system) return null;

        $role = $system->pivot->role;

        $permissions = SystemPermission::where('system_id', $system->id)
            ->whereIn('id', function ($query) use ($system, $role) {
                $query->select('permission_id')
                    ->from('system_role_permissions')
                    ->where('system_id', $system->id)
                    ->where('role', $role);
            })
            ->get()
            ->map(fn ($p) => ['slug' => $p->slug, 'name' => $p->name, 'group' => $p->group])
            ->toArray();

        return [
            'system_id' => $system->id,
            'system_name' => $system->name,
            'system_slug' => $system->slug,
            'role' => $role,
            'permissions' => array_column($permissions, 'slug'),
            'permissions_detail' => $permissions,
        ];
    }
}
