<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SystemPermission extends Model
{
    protected $fillable = [
        'system_id',
        'name',
        'slug',
        'group',
    ];

    public function system()
    {
        return $this->belongsTo(System::class);
    }
}
