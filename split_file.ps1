Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Separador de arquivos'
$form.Size = New-Object System.Drawing.Size(450,200)
$form.MaximumSize = $form.Size
$form.StartPosition = 'CenterScreen'
$form.MaximizeBox = $false


$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(10,120)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(90,120)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Programa para separar arquivos de texto'
$form.Controls.Add($label)

$label_1 = New-Object System.Windows.Forms.Label
$label_1.Location = New-Object System.Drawing.Point(10, 50)
$label_1.Size = New-Object System.Drawing.Size(100, 20)
$label_1.Text = 'Diretório:'
$label_1.TextAlign = 'MiddleLeft'
$form.Controls.Add($label_1)

$label_2 = New-Object System.Windows.Forms.Label
$label_2.Location = New-Object System.Drawing.Point(10, 80)
$label_2.Size = New-Object System.Drawing.Size(100, 20)
$label_2.Text = 'Nome do Arquivo'
$label_2.TextAlign = 'MiddleLeft'
$form.Controls.Add($label_2)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(120,50)
$textBox.Size = New-Object System.Drawing.Size(300,20)
$form.Controls.Add($textBox)

$textBox_1 = New-Object System.Windows.Forms.TextBox
$textBox_1.Location = New-Object System.Drawing.Point(120, 80)
$textBox_1.Size = New-Object System.Drawing.Size(300, 20)
$form.Controls.Add($textBox_1)


$form.Topmost = $true

$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK -and $textBox.Text -ne '' -and $textBox_1.Text -ne '')
{
    $source = $textBox.Text
    $file = $textBox_1.Text

    Get-Content -Path ("$source\$file") -ReadCount 2 |
        ForEach-Object -Begin{$out= (New-Item -Path $source -Name "saida" -ItemType "directory" -Force);$i=0} -Process{$i++;"Out_$i"; Out-File -FilePath "$out\Out_$i.txt" -InputObject $_}
}