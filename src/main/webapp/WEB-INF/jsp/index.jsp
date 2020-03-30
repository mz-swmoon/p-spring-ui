<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sample App</title>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no"/>
    <link rel="stylesheet" href="/resources/static/assets/css/main.css"/>
    <noscript>
        <link rel="stylesheet" href="/resources/static/assets/css/noscript.css"/>
    </noscript>
</head>
<body class="is-preload" style="overflow:hidden;height: 100%;">

<!-- Header -->
<section id="header">
    <div class="inner">
        <span class="icon major fa-cloud"></span>

        <h1>Sample App</h1>

        <div class="row" style="height: 100%">
            <div class="col-6">
                <button onclick='procCallAjax("/r/users", r_mysql)' style="text-align: left">Registry 데이터 가져오기</button>
                <br>
                <table>
                    <thead>
                    <tr>
                        <td width="25%">ID</td>
                        <td width="25%">Name</td>
                        <td width="25%">Phone</td>
                        <td width="25%">Age</td>
                    </tr>
                    </thead>
                    <tbody id="r_mysql"></tbody>
                </table>
                <div id="ghost">
                    <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

                </div>
            </div>
            <div class="col-6">
                <button onclick='procCallAjax("/g/users", g_mysql)'> Gateway 데이터 가져오기 </button>
                <table>
                    <thead>
                    <tr>
                        <td>ID</td>
                        <td>Name</td>
                        <td>Email</td>
                        <td>Created on</td>
                    </tr>
                    </thead>
                    <tbody id="g_mysql"></tbody>
                </table>
            </div>
        </div>

        <!-- Scripts -->
        <script src="/resources/static/assets/js/jquery.min.js"></script>
        <script src="/resources/static/assets/js/browser.min.js"></script>
        <script src="/resources/static/assets/js/breakpoints.min.js"></script>
        <script src="/resources/static/assets/js/main.js"></script>

</body>
</html>
<script type="text/javascript">

    var procCallAjax = function (reqUrl, callback) {
        var reqData = "";
        $.ajax({
            url: reqUrl,
            method: "GET",
            dataType: 'json',
            async: false,
            contentType: "application/json",
            success: function (data) {
                callback(data);
            },
            error: function (xhr, status, error) {
                //alert("api error message");
            },
            complete: function (data) {
                // SKIP
                console.log("COMPLETE :: data :: ", data);
            }
        });
    };

    var r_mysql = function (data) {
        var dataStr = [];
        $.each(data, function (index, item) {
            console.log(item);
            dataStr.push('<tr>' +
                '<td>' + item.id + '</td>' +
                '<td>' + item.guid + '</td>' +
                '<td>' + item.phone + '</td>' +
                "<td>" + item.age + "</td>" +
                '</tr>');

        });
        $('#r_mysql').html(dataStr);
        $('#ghost').hide();
    }

    var g_mysql = function (data) {
        var dataStr = [];
        $.each(data, function (index, item) {
            console.log(item);
            dataStr.push('<tr>' +
                '<td>' + item.id + '</td>' +
                '<td>' + item.guid + '</td>' +
                '<td>' + item.phone + '</td>' +
                "<td>" + item.age + "</td>" +
                '</tr>');

        });
        $('#g_mysql').html(dataStr);
        $('#ghost').hide();
    }

</script>
