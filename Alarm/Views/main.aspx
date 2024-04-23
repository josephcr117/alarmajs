<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="main.aspx.cs" Inherits="Alarm.Views.main" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Alarm App</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
    <div class="container mt-5">
        <h1 class="mb-4">Alarm App</h1>

        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Add Alarm</h5>
                <div class="form-group">
                    <label for="txtTime">Time:</label>
                    <input type="datetime-local" id="txtTime" class="form-control" required="required" step="1"/>
                    <div class="invalid-feedback">Please enter a time.</div>
                </div>
                <div class="form-group">
                    <label for="txtName">Name:</label>
                    <input type="text" id="txtName" class="form-control" required="required" />
                </div>
                <div class="form-group">
                    <label>Days:</label><br />
                    <div class="form-check form-check-inline">
                        <input type="checkbox" class="form-check-input" name="chkDay" value="Monday" />
                        <label class="form-check-label">Monday</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input type="checkbox" class="form-check-input" name="chkDay" value="Tuesday" />
                        <label class="form-check-label">Tuesday</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input type="checkbox" class="form-check-input" name="chkDay" value="Wednesday" />
                        <label class="form-check-label">Wednesday</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input type="checkbox" class="form-check-input" name="chkDay" value="Thursday" />
                        <label class="form-check-label">Thursday</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input type="checkbox" class="form-check-input" name="chkDay" value="Friday" />
                        <label class="form-check-label">Friday</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input type="checkbox" class="form-check-input" name="chkDay" value="Saturday" />
                        <label class="form-check-label">Saturday</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input type="checkbox" class="form-check-input" name="chkDay" value="Sunday" />
                        <label class="form-check-label">Sunday</label>
                    </div>
                </div>
                <button type="button" class="btn btn-primary" onclick="addAlarm()">Add Alarm</button>
            </div>
        </div>

        <div class="card mt-4">
            <div class="card-body">
                <h5 class="card-title">Alarms</h5>
                <ul id="alarmList" class="list-group">
                </ul>
            </div>
        </div>

        <div id="alarmMessage" class="alert alert-success mt-4" style="display: none;">
            It's time for your alarm!
        </div>

        <div class="mt-4">
            <asp:Label ID="lblMessage" runat="server" CssClass="alert" EnableViewState="false"></asp:Label>
        </div>
    </div>

    <script type="text/javascript">
        function addAlarm() {
            var timeInput = document.getElementById("txtTime").value;
            var name = document.getElementById("txtName").value;
            var days = [];
            var checkboxes = document.getElementsByName("chkDay");
            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].checked) {
                    days.push(checkboxes[i].value);
                }
            }

            var alarmTime = new Date(timeInput);
            var currentTime = new Date();

            if (alarmTime <= currentTime) {
                alert("Please select a future time for the alarm.");
                return;
            }

            var newAlarm = {
                Time: timeInput,
                Name: name,
                Days: days,
                IsActive: true
            };

            var alarmList = document.getElementById("alarmList");
            var listItem = document.createElement("li");
            listItem.textContent = "Name: " + newAlarm.Name + ", Time: " + newAlarm.Time + ", Days: " + newAlarm.Days.join(", ");
            listItem.className = "list-group-item";

            var deleteButton = document.createElement("button");
            deleteButton.textContent = "Delete";
            deleteButton.className = "btn btn-danger btn-sm float-right";
            deleteButton.onclick = function () {
                listItem.remove();
            };
            listItem.appendChild(deleteButton);

            alarmList.appendChild(listItem);

            var timeDifference = alarmTime.getTime() - currentTime.getTime();

            setTimeout(function () {
                alert("Alarm: " + newAlarm.Name);
            }, timeDifference);

            document.getElementById("txtTime").value = "";
            document.getElementById("txtName").value = "";
            for (var i = 0; i < checkboxes.length; i++) {
                checkboxes[i].checked = false;
            }
        }
    </script>
</body>
</html>
