

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-58290407-2"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-58290407-2');
</script>
    <title>
	Clubspeed Live Scores
</title><link href="Clubspeed.css" type="text/css" rel="Stylesheet" /><link href="../SP_Center/css/bootstrap.css" type="text/css" rel="Stylesheet" />
    <script src="Scripts/jquery-1.6.4.min.js" type="text/javascript"></script>
    <script src="Scripts/json2.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery.signalR.min.js" type="text/javascript"></script>
    <script type="text/javascript" src='signalr/hubs'></script>
    <script type="text/javascript">

        var positionHdr = 'Position'
        var kartHdr = 'Kart'
        var racerHdr = 'Racer'
        var lapHdr = 'Lap Time'
        var bestLTimeHdr = 'Best Lap Time'
        var lapNoHdr = 'Laps'
        var gapHdr = 'Gap'

        var gridTemplate = '<tr></tr>';
        var colModels = [
                            { "colName": "Position", "colHeader": positionHdr, "HeaderCssClass": "RankColumnStyle", "ItemCSSClass": "RankColumnStyle" },
                            { "colName": "AutoNo", "colHeader": kartHdr, "HeaderCssClass": "KartColumnStyle", "ItemCSSClass": "KartColumnStyle" },
                            { "colName": "RacerName", "colHeader": racerHdr, "HeaderCssClass": "RacerNameColumnStyle", "ItemCSSClass": "RacerNameColumnStyle" },
                            { "colName": "LTime", "colHeader": lapHdr, "HeaderCssClass": "LapTimeColumnStyle", "ItemCSSClass": "LapTimeColumnStyle" },
                            { "colName": "BestLTime", "colHeader": bestLTimeHdr, "HeaderCssClass": "BestLapTimeColumnStyle", "ItemCSSClass": "BestLapTimeColumnStyle" },
                            { "colName": "LapNum", "colHeader": lapNoHdr, "HeaderCssClass": "LapsStyle", "ItemCSSClass": "LapsStyle" },
                            { "colName": "GapToLeader", "colHeader": gapHdr, "HeaderCssClass": "LapTimeColumnStyle", "ItemCSSClass": "LapTimeColumnStyle" }
                        ];


        var updateRaceInfo = function (data) {
            $.tblCellHeatType.html(data.HeatTypeName)
            $.tblCellWinBy.html(data.Winby)
            $.tblCellLapsTogo.html(data.LapsLeft)

            if (!data.RaceRunning && data.ScoreboardData.length > 0) {
                displayWinners(data.Winners);
            }
            else {
                hideWinners();
            }
            createGrid(data.ScoreboardData)
        }
        var createGrid = function (data) {
            var dataRow = [];
            var headerRow = [];


            for (j = 0; j < colModels.length; j++) {
                headerRow.push('<th class="' + colModels[j].HeaderCssClass + '">' + colModels[j].colHeader + '</th>')
            }


            for (i = 0; i < data.length; i++) {
                var cssClass = "";
                if (i % 2) {
                    cssClass = "TableItemStyle";
                }
                else {
                    cssClass = "AlternateItemStyle";
                }
                dataRow.push('<tr class="' + cssClass + '">');

                for (j = 0; j < colModels.length; j++) {
                    dataRow.push('<td class="' + colModels[j].ItemCSSClass + '">' + data[i][colModels[j].colName] + '</td>')
                }
                dataRow.push('</tr>');
            }

            var html = '<table width="100%" class="NewTableStyle"><thead><tr class="TableHeaderStyle">' + headerRow.join('') + '</thead></tr><tbody>' + dataRow.join('') + '</tbody></table>';

            $.grid.html(html);

        }
        var displayWinners = function (winners) {

            for (i = 0; i < winners.length && i < 3; i++) {
                if (i == 0) { //first place
                    $.lblWinner.html(winners[i].RacerName)
                    $.lblKartNo.html(winners[i].KartNo)
                    $.lblBestLap.html(winners[i].BestLap)
                    $.lblLaps.html(winners[i].Laps)
                    $.imgRaceWinner.show().attr('src', winners[i].CustImage)
                    $.imgSecondPlace.show().attr('src', winners[i].CustImage)
                   
                   
                }
                else if (i == 1) { //second place

                    $.lblSecondPlaceName.html(winners[i].RacerName)
                    $.lblKartNo2nd.html(winners[i].KartNo)
                    $.lblBestLap2nd.html(winners[i].BestLap)
                    $.lblLaps2nd.html(winners[i].Laps)
                    $.imgSecondPlace.show().attr('src', winners[i].CustImage)
                 

                }
                else if (i == 2) { //third place
                    $.lblThirdPlaceName.html(winners[i].RacerName)
                    $.lblKartNo3rd.html(winners[i].KartNo)
                    $.lblBestLap3rd.html(winners[i].BestLap)
                    $.lblLaps3rd.html(winners[i].Laps)
                    $.imgThirdPlace.show().attr('src', winners[i].CustImage)
                    

                }
            }

            $.winners.show();
        }
        var hideWinners = function () {
            $.imgRaceWinner.attr('src', '').hide()
            $.imgSecondPlace.attr('src', '').hide()
            $.imgThirdPlace.attr('src', '').hide()
            $.winners.hide();
        }
        var connection;
        $(function () {


            $.grid = $("#grid");
            $.winners = $("#winners");
            $.ddlTrack = $("#ddlTrack");

            $.tblCellHeatType = $("#tblCellHeatType");
            $.tblCellWinBy = $("#tblCellWinBy");
            $.tblCellLapsTogo = $("#tblCellLapsTogo");

            $.lblWinner = $("#lblWinner");
            $.lblKartNo = $("#lblKartNo");
            $.lblBestLap = $("#lblBestLap");
            $.lblLaps = $("#lblLaps");


            $.imgSecondPlace = $("#imgSecondPlace");
            $.imgRaceWinner = $("#imgRaceWinner");
            $.imgThirdPlace = $("#imgThirdPlace");


            $.lblSecondPlaceName = $("#lblSecondPlaceName");
            $.lblKartNo2nd = $("#lblKartNo2nd");
            $.lblBestLap2nd = $("#lblBestLap2nd");
            $.lblLaps2nd = $("#lblLaps2nd");

            $.lblThirdPlaceName = $("#lblThirdPlaceName");
            $.lblKartNo3rd = $("#lblKartNo3rd");
            $.lblBestLap3rd = $("#lblBestLap3rd");
            $.lblLaps3rd = $("#lblLaps3rd");



            var scoreboard = $.connection.ScoreBoardHub;



            $.ddlTrack.unbind('change');
            $.ddlTrack.bind('change', function () {
                var trackNo = $.ddlTrack.find("option:selected").val();
                scoreboard.getDataByTrack(trackNo).done(function (data) {
                    updateRaceInfo(data)
                });



            })

            scoreboard.refreshGrid = function (data) {
                updateRaceInfo(data)
            }




            // Start the connection
            $.connection.hub.start(function () {
                var trackNo = $.ddlTrack.find("option:selected").val();
                scoreboard.getDataByTrack(trackNo).done(function (data) {
                    updateRaceInfo(data)
                });
            });



        });
        
    </script>
</head>
<body style="background: #000;">
    <form name="form1" method="post" action="./livescore.aspx" id="form1">
<div>
<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwUKMTMyNTQ2OTE2OQ9kFgICAw9kFgQCAQ8QDxYGHg5EYXRhVmFsdWVGaWVsZAUHVHJhY2tObx4NRGF0YVRleHRGaWVsZAUJVHJhY2tOYW1lHgtfIURhdGFCb3VuZGdkEBUEB0thcnRpbmcEVEVTVApLaWRzIFRyYWNrBEF1ZGkVBAExATIBMwE0FCsDBGdnZ2dkZAIDDw8WAh4HVmlzaWJsZWhkZGRbDpqaF64HjI8a7GWH+n0un/MJT/XLWS4CUlmMUHW4LQ==" />
</div>

<div>

	<input type="hidden" name="__VIEWSTATEGENERATOR" id="__VIEWSTATEGENERATOR" value="052DA306" />
	<input type="hidden" name="__EVENTVALIDATION" id="__EVENTVALIDATION" value="/wEdAAUbBL33/Uj+aI4Xw39jJQXspj3ZbD9z2C3vDOiFtD5M5G8Fx62gyL0tdXKMSQTmkECJztVioSVMcG6Mwgg+cfX+tVzmntOhVWJ7aS6Zx9InKIUuyLgmskZpB3heSdjMmvWQ0uksry2JE3ftaKn8Gmyq" />
</div>
    <table class="NewTableStyle" align="Center" width: 100%">
        <tr>
            <td rowspan="3">
                <span id="lblSelectTrack" style="color:Gray;">Select Track here </span>
                <select name="ddlTrack" id="ddlTrack" class="btn-sm btn-secondary">
	<option value="1">Karting</option>
	<option value="2">TEST</option>
	<option value="3">Kids Track</option>
	<option value="4">Audi</option>

</select>
                <span id="lblHeader" style="color:White;"></span>
                
            </td>
            <td>
                <span id="lblTime"></span>
            </td>
        </tr>
    </table>
    <table style="background-color: Gray; width: 100%" class="backImage" align="Center">
        <tr>
            <td class="backImage">
                <img class="csLogo" src="images/CS_live.png" />
            </td>
            <td class="backImage" id="tblCellLocation">
            </td>
        </tr>
    </table>
    <table style="width: 100%; background-color: gray">
        <tr>
            <td class="backImage" width="33%" align="Center" id="tblCellHeatType">
            </td>
            <td width="33%" align="Center" id="tblCellWinBy">
            </td>
            <td class="backImage" width="33%" align="Center" id="tblCellLapsTogo">
            </td>
        </tr>
    </table>
    <div id="grid" style="width: 100%">
    </div>
    <table id="winners" class="hide" style="width: 100%">
        <thead>
            <tr>
                <th>
                </th>
                <th>
                    
                </th>
                <th>
                </th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td class="leftTableCell">
                    <img id="imgSecondPlace" class="secondPlacePic" alt="Second Place" />
                </td>
                <td class="centerTabeCell">
                    <img id="imgRaceWinner" class="winnerPic" alt="Winner" />
                </td>
                <td class="rightTableCell">
                    <img id="imgThirdPlace" class="thirdPlacePic" alt="Third Place" />
                </td>
            </tr>
            <tr>
                <td colspan="3" class="podiumCell" align="Center" valign="Top">
                    <img src="images/podium.png" class="imgStyle" />
                </td>
            </tr>
            <tr>
                <td class="secondPlaceName">
                    <div>
                        <span id="lblSecondPlaceName"></span>
                        <br />
                        Kart No:<span id="lblKartNo2nd" style="width: 160px"></span><br />
                        Best Lap:<span id="lblBestLap2nd"></span><br />
                        Laps:<span id="lblLaps2nd"></span>
                    </div>
                </td>
                <td class="winnerStyle">
                    <div>
                        <span id="lblWinner">Winner</span><br />
                        Winner<br />
                        Kart No:<span id="lblKartNo" style="width: 160px"></span><br />
                        Best Lap: <span id="lblBestLap"></span>
                        <br />
                        Laps: <span id="lblLaps"></span>
                    </div>
                </td>
                <td class="thirdPlaceName">
                    <div>
                        <span id="lblThirdPlaceName"></span>
                        <br />
                        Kart No: <span id="lblKartNo3rd" style="width: 160px"></span>
                        <br />
                        Best Lap: <span id="lblBestLap3rd"></span>
                        <br />
                        Laps:<span id="lblLaps3rd"></span>
                    </div>
                </td>
            </tr>
        </tbody>
    </table>
    <table style="background-color: #000; width: 100%; text-align: center; margin-top:20px;">
        <tbody>
            <tr>
                <td class="leftAdv" align="center">
                    <!-- CS Live Score Powered by: -->
                </td>
                <td class="clubSpeed">
                    <a href="http://www.clubspeed.com" style="color:#2f2f2f;" target="_blank">www.clubspeed.com</a>
                </td>
                <td class="leftAdv">
                    <span class="leftAdv" id="lblTrackRecord"></span>
                </td>
            </tr>
        </tbody>
    </table>
    <script type="text/javascript">

        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', 'UA-21724289-2']);
        _gaq.push(['_trackPageview']);

        (function () {
            var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
            ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
            var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();
 
    </script>
    </form>
</body>
</html>
