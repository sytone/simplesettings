---
external help file: SimpleSettings-help.xml
Module Name: SimpleSettings
online version:
schema: 2.0.0
---

# Show-SimpleSetting

## SYNOPSIS
Show a setting in the settings file.

## SYNTAX

```
Show-SimpleSetting [-AsJson] [[-ConfigFile] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Show a setting in the settings file.
The settings file is a JSON file that contains the settings you use in PowerShell scripts.
The setting will be shown as a JSON object or as a PowerShell object.

## EXAMPLES

### EXAMPLE 1
```
Show-SimpleSetting
Show-SimpleSetting -AsJson
Show-SimpleSetting -ConfigFile "C:\MySettings.json"
Show-SimpleSetting -AsJson -ConfigFile "C:\MySettings.json"
```

## PARAMETERS

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

### -ConfigFile
The path to the settings file.

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
