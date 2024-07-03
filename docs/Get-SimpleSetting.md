---
external help file: SimpleSettings-help.xml
Module Name: SimpleSettings
online version:
schema: 2.0.0
---

# Get-SimpleSetting

## SYNOPSIS
Get a setting from the settings file.

## SYNTAX

```
Get-SimpleSetting [[-Name] <String>] [[-Section] <String>] [[-DefaultValue] <Object>] [[-ConfigFile] <String>]
 [-MachineSpecific] [-AsJson] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Get a setting from the settings file.
The settings file is a JSON file that contains the settings you use in PowerShell scripts.

## EXAMPLES

### EXAMPLE 1
```
Get-SimpleSetting -Name "MySetting" -Section "MySection" -DefaultValue "MyDefaultValue" -ConfigFile "C:\MySettings.json"
```

This will get the setting "MySetting" from the section "MySection" in the settings file "C:\MySettings.json".
If the setting is not found it will return "MyDefaultValue".

## PARAMETERS

### -Name
The name of the setting you want to get.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Section
The section of the setting you want to get.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultValue
The default value of the setting you want to get.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ConfigFile
The path to the settings file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MachineSpecific
If the setting is machine specific.
It will look for a value in the configuration using the name prefixed with the machine name.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AsJson
If the output should be in JSON format.
Otherwise it is the object.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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

### Object or JSON
## NOTES

## RELATED LINKS
