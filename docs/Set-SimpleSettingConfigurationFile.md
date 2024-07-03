---
external help file: SimpleSettings-help.xml
Module Name: SimpleSettings
online version:
schema: 2.0.0
---

# Set-SimpleSettingConfigurationFile

## SYNOPSIS
Set the configuration file path for SimpleSettings.

## SYNTAX

```
Set-SimpleSettingConfigurationFile [-Path] <String> [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Set the configuration file path for SimpleSettings.
The configuration file is a JSON file that contains the settings you use in PowerShell scripts.

## EXAMPLES

### EXAMPLE 1
```
Set-SimpleSettingConfigurationFile -Path "C:\MySettings.json"
```

This will set the configuration file path for SimpleSettings to "C:\MySettings.json".

## PARAMETERS

### -Path
The path to the settings file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### None
## NOTES

## RELATED LINKS
