<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Branch extends Model
{
    protected $fillable = [
        'branch_name',
        'brak',
        'brcode',
        'parent_id',
        'is_active',
    ];

    protected function casts(): array
    {
        return [
            'is_active' => 'boolean',
        ];
    }

    public function users()
    {
        return $this->hasMany(User::class);
    }

    public function parent()
    {
        return $this->belongsTo(Branch::class, 'parent_id');
    }

    public function children()
    {
        return $this->hasMany(Branch::class, 'parent_id');
    }

    public function isMotherBranch(): bool
    {
        return is_null($this->parent_id);
    }

    public function getDisplayNameAttribute(): string
    {
        return "{$this->branch_name} ({$this->brak})";
    }
}
