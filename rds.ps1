add-type -AssemblyName System.Windows.Forms
$name=Invoke-Command -ComputerName PLASMAMED-DESK -ScriptBlock {C:\python\rds-a.ps1}#使用中の確認　使用中→名前　未使用→nouser
if ($name -eq "nouser"){
	#使用者無しの場合
	#強制ログオフ
	Invoke-Command -ComputerName PLASMAMED-DESK -ScriptBlock {logoff}
	Invoke-Expression "mstsc /v:PLASMAMED-DESK"
}else{
	#使用者ありの場合
	#共有PC権限位置確認
	try{
		$query=Invoke-Command -ComputerName PLASMAMED-DESK -ScriptBlock {query user console}
		$query="$query"
		if ($query -like "*plasma medicine*"){
			$permissions = "commonPC"
		}else{
			$permissions = "no"
		}
	}catch{
		$permissions = "no"
	}
	if ($permissions -eq "no"){
		#RDS使用者がいる場合
		$message=$name + "が接続中です。"
		$wsobj = new-object -comobject wscript.shell
		$result = $wsobj.popup($message)
	}else{
		#画面の判断
		$monitor=Invoke-Command -ComputerName PLASMAMED-DESK -ScriptBlock {(Get-WmiObject Win32_DesktopMonitor)}
		$monitor=$monitor[0].Name
		$monitor="$monitor"
		if ($monitor -like "*標準のモニター*"){
			#画面がオフの場合
			$query2=Invoke-Command -ComputerName PLASMAMED-DESK -ScriptBlock {quser | Where-Object {$_ -match "Active"}}
			$id=($query2 -split " +" )[4]
			Invoke-Command -ComputerName PLASMAMED-DESK -ScriptBlock {logoff $args[0]} -ArgumentList $id
			Invoke-Expression "mstsc /v:PLASMAMED-DESK"
		}else{
			#画面がオンの場合
			$message="直接使用している人がいます。"
			$wsobj = new-object -comobject wscript.shell
			$result = $wsobj.popup($message)
		}
	}
}