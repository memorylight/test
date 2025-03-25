# 引入 System.IO.Ports 命名空间
Add-Type -TypeDefinition @"
    using System;
    using System.IO.Ports;
"@

# 创建 SerialPort 对象并配置串口参数
$serialPort = New-Object System.IO.Ports.SerialPort
$serialPort.PortName = "COM4"  # 修改为实际串口号
$serialPort.BaudRate = 115200
$serialPort.Parity = [System.IO.Ports.Parity]::None
$serialPort.DataBits = 8
$serialPort.StopBits = [System.IO.Ports.StopBits]::One

# 打开串口
$serialPort.Open()

# 创建CSV文件路径
$csvFilePath = "C:\path\to\output.csv"

# 初始化CSV文件，写入表头
"Binary Data" | Out-File -FilePath $csvFilePath -Encoding UTF8

# 连续读取串口数据并写入CSV
while ($true) {
    if ($serialPort.BytesToRead -gt 0) {
        $data = $serialPort.ReadExisting()
        # 将数据按8位二进制划分
        $binaryData = [System.Text.Encoding]::ASCII.GetBytes($data) | ForEach-Object {
            [Convert]::ToString($_, 2).PadLeft(8, '0')
        }
        # 将二进制数据写入CSV
        $binaryData | Out-File -FilePath $csvFilePath -Append -Encoding UTF8
    }
}

# 关闭串口
$serialPort.Close()