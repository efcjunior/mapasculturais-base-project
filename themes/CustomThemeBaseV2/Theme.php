<?php

namespace CustomThemeBaseV2;

use MapasCulturais\Themes\BaseV2;

/**
 * @method void import(string $components) Importa lista de componentes Vue. * 
 */
class Theme extends BaseV2\Theme
{    
    static function getThemeFolder()
    {
        return __DIR__;
    }
}
