<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<body>
	<#include "top_banner.ftl">
	选择应用节点：
	<select id="ipId" onchange="changeIp(this.value)">
		<option value ="" selected>全部节点</option>
	</select>
	选择查看的时间：
	<select id="lastMinutesId" name="lastMinutes" onchange="changeLastMinutes(this.value)">
		<#if !lastMinutes??>
			 <#assign lastMinutes=10/> 
		</#if>
		<option value ="5" <#if lastMinutes??><#if lastMinutes==5>selected</#if></#if>>最近5分</option>
		<option value ="10" <#if lastMinutes??><#if lastMinutes==10>selected</#if></#if>>最近10分</option>
		<option value ="20" <#if lastMinutes??><#if lastMinutes==20>selected</#if></#if>>最近20分</option>
		<option value ="30" <#if lastMinutes??><#if lastMinutes==30>selected</#if></#if>>最近30分</option>
		<option value ="60" <#if lastMinutes??><#if lastMinutes==60>selected</#if></#if>>最近60分</option>
	</select>
	<input type="hidden" name="appName" id="appName" value="${appName!''}">
	<input type="hidden" name="clientIp" id="clientIp" value="${ip!''}">
	<input type="hidden" name="lastMinutes" id="lastMinutes" value="${lastMinutes!''}">
	<br>
	<table width="100%" border="1">
		<tr>
			<td colspan="6" align="center" style="font-weight:bold">最近１小时的IP访问TOP统计（以分钟为统计维度）</td>
		</tr>
		<tr>
			<td style="font-weight:bold;background-color:yellow" width="16%">统计时间</td>
			<td style="font-weight:bold;background-color:yellow" width="16%"><b>IP</b></td>
			<td style="font-weight:bold;background-color:yellow" width="16%">访问总量</td>
			<td style="font-weight:bold;color:green;background-color:yellow" width="16%">正常访问总量</td>
			<td style="font-weight:bold;color:red;background-color:yellow" width="16%">拒绝访问总量</td>
			<td style="font-weight:bold;color:red;background-color:yellow" width="20%">操作</td>
		</tr>
		<#if minutesDatas??>
		<#list minutesDatas as minuteDatas>
		<#assign index=0>
		<#list minuteDatas as minuteData>
		<tr>
			<#if index==0>
			<td rowspan="${minuteDatas?size}">${minuteData.currentDate}</td>
			</#if>
			<td>${minuteData.ip}</td>
			<td>${minuteData.total}</td>
			<td>${minuteData.normal}</td>
			<td>${minuteData.block}</td>
			<td><a href="/limiter/blackIp/addBlackIpPretty?ip=${minuteData.ip}<#if appName??>&appName=${appName}</#if>">IP加入黑名单</a></td>
		</tr>
		<#assign index=index+1>
		</#list>
		</#list>
		</#if>
	</table>
</body>
<#include "loadAppNodesJs.ftl">
<script language="JavaScript">
	function changeIp(ip){
		var appName = document.getElementById("appName").value;
		var lastMinutes = document.getElementById("lastMinutes").value;
		var ts = new Date().getTime();
		window.location.href="/limiter/getMinutesDataPretty?appName="+appName+"&ip="+ip+"&ts="+ts+"&lastMinutes="+lastMinutes;
	}
	function changeLastMinutes(lastMinutes){
		var appName = document.getElementById("appName").value;
		var ip = document.getElementById("ipId").value;
		var ts = new Date().getTime();
		window.location.href="/limiter/getMinutesDataPretty?appName="+appName+"&ip="+ip+"&ts="+ts+"&lastMinutes="+lastMinutes;
	}
	function page_refresh()
	{
		var appName = document.getElementById("appName").value;
		var ip = document.getElementById("ipId").value;
		var lastMinutes = document.getElementById("lastMinutes").value;
		var ts = new Date().getTime();
		window.location.href="/limiter/getMinutesDataPretty?appName="+appName+"&ip="+ip+"&ts="+ts+"&lastMinutes="+lastMinutes;
	}
	setTimeout('page_refresh()',60000); //指定60秒刷新一次
</script>
</html>
