<?php

namespace Database\Seeders;

use App\Models\Branch;
use Illuminate\Database\Seeder;

class BranchSeeder extends Seeder
{
    public function run(): void
    {
        $branches = [
            ['branch_name' => 'Head Office',           'brak' => 'HO',           'brcode' => '00', 'parent_id' => null],
            ['branch_name' => 'Main Office',            'brak' => 'MO',           'brcode' => '01', 'parent_id' => null],
            ['branch_name' => 'Jasaan Branch',          'brak' => 'JB',           'brcode' => '02', 'parent_id' => null],
            ['branch_name' => 'Salay Branch',           'brak' => 'SB',           'brcode' => '03', 'parent_id' => null],
            ['branch_name' => 'CDO Branch',             'brak' => 'CDOB',         'brcode' => '04', 'parent_id' => null],
            ['branch_name' => 'Maramag Branch',         'brak' => 'MB',           'brcode' => '05', 'parent_id' => null],
            ['branch_name' => 'Gingoog Branch Lite',    'brak' => 'GNG-BLU',      'brcode' => '06', 'parent_id' => null],
            ['branch_name' => 'Camiguin Branch Lite',   'brak' => 'CMG-BLU',      'brcode' => '07', 'parent_id' => null],
            ['branch_name' => 'Butuan Branch Lite',     'brak' => 'BXU-BLU',      'brcode' => '08', 'parent_id' => null],
            ['branch_name' => 'Kibawe Branch Lite',     'brak' => 'KIBAWE-BLU',   'brcode' => '09', 'parent_id' => null],
            ['branch_name' => 'Claveria Branch Lite',   'brak' => 'Claveria-BLU', 'brcode' => '10', 'parent_id' => null],
        ];

        foreach ($branches as $branchData) {
            Branch::firstOrCreate(
                ['brcode' => $branchData['brcode']],
                $branchData
            );
        }

        $this->command->info('11 branches seeded successfully.');
    }
}
