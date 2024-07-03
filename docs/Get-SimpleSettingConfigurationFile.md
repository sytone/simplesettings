---
external help file: SimpleSettings-help.xml
Module Name: SimpleSettings
online version:
schema: 2.0.0
---

# Get-SimpleSettingConfigurationFile

## SYNOPSIS
Get the configuration file path for SimpleSettings.

## SYNTAX

```
Get-SimpleSettingConfigurationFile [[-Path] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Get the configuration file path for SimpleSettings.
The configuration file is a JSON file that contains the settings you use in PowerShell scripts.

## EXAMPLES

### EXAMPLE 1
```
Get-SimpleSettingConfigurationFile -Path "C:\MySettings.json"
```

This will get the configuration file path for SimpleSettings.
If the Path is not provided it will use the default configuration file path.

## PARAMETERS

### -Path
The path to the settings file.

```yaml
Type: String
Parameter Sets: (All)
Aliases: override

Required: False
Position: 1
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

### String
## NOTES

## RELATED LINKS
