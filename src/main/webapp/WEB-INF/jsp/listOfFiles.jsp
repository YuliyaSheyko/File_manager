<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=utf-8" %>

<fmt:setLocale value="${param.lang}" />
<fmt:setBundle basename="messages" />

<html>

<head>
    <meta charset="UTF-8">
    <title>File manager</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
    <link href='https://fonts.googleapis.com/css?family=Lato:400,700' rel='stylesheet' type='text/css'>
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet">
</head>

<body>
    <fmt:message key="label.upload" var="Upload" />
    <fmt:message key="label.nfile" var="NFile" />
    <fmt:message key="label.chooseF" var="Choose" />
    <fmt:message key="label.directory" var="Directory" />
    <fmt:message key="label.submit" var="Submit" />
    <fmt:message key="label.create" var="Create" />
    <fmt:message key="label.note" var="Note" />
    <fmt:message key="label.save" var="Save" />
    <fmt:message key="label.type" var="Type" />
    <fmt:message key="label.comment" var="Comment" />
    <fmt:message key="label.folder" var="Folder" />



    <input class="upload" type="submit" value="${Upload}">
    <input class="create-btn" type="button" value="${NFile}">
    <input class="uploadD" type="submit" value="${Folder}">
    <input type="button" class="lang" onclick="location.href='http://127.0.0.1:8080/list?directory=/Users/Yulya&lang=en';" value="EN" />
    <form class="uploadForm" method="POST" enctype="multipart/form-data" action="/upload">
        <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span>
        <p>${Choose}</p><input class="buttonLabel" type="file" name="file">
        <p>${Directory}</p> <input class="button" id="dirname" type="text" name="directory" value="${directory}">
        <input type="submit" value="${Submit}" id="dataUpload" class="button">
    </form>

    <ul class="dirborder">
        <li><a href="/list?directory=${parent}">..</a></li>
    </ul>
    <c:forEach items="${files}" var="file">

        <c:choose>
            <c:when test="${file.isTxt}">
                <ul class="pathborder">
                    <li>
                        <input type="button" file="${file.path}" value="${Note}" class="note-btn">${file.path}<input file="${file.path}" class="remove-btn" type="image" img src="https://img.icons8.com/officel/24/000000/multiply.png" /><input file="${file.path}" type="image" class="download-btn" img src="https://img.icons8.com/material/24/000000/download--v1.png"><input file="${file.path}" type="image" class="edit-btn" img src="https://img.icons8.com/ultraviolet/24/000000/edit.png">
                        <c:choose>
                            <c:when test="${file.isRead}">
                                R
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${file.isWrite}">
                                W
                            </c:when>
                        </c:choose>
                    </li>
                </ul>
            </c:when>
            <c:when test="${file.isDirectory}">
                <ul class="border">
                    <li>
                        <input file="${file.path}" type="button" value="${Note}" class="note-btn"><a href="/list?directory=${file.path}">${file.path}</a> <input file="${file.path}" class="remove-btn" type="image" img src="https://img.icons8.com/officel/24/000000/multiply.png" />
                        <c:choose>
                            <c:when test="${file.isRead}">
                                R
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${file.isWrite}">
                                W
                            </c:when>
                        </c:choose>
                    </li>
                </ul>
            </c:when>
            <c:otherwise>
                <ul class="pathborder">
                    <li>
                        <input type="button" file="${file.path}" value="${Note}" class="note-btn">${file.path}<input file="${file.path}" class="remove-btn" type="image" img src="https://img.icons8.com/officel/24/000000/multiply.png" /><input file="${file.path}" type="image" class="download-btn" img src="https://img.icons8.com/material/24/000000/download--v1.png">
                        <c:choose>
                            <c:when test="${file.isRead}">
                                R
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${file.isWrite}">
                                W
                            </c:when>
                        </c:choose>
                    </li>
                </ul>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <form class="myForm" action="#" method="post" name="creating a file">
        <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span>
        <div class="container">
            <p>${Create}</p>
        </div>
        <div class="input">
            <input type="checkbox" id="read"> <label>Readable</label>
            <input type="checkbox" id="write"> <label>Writable</label>
            <input type="text" class="button" id="filename" name="filename" placeholder="${Type}">
            <input type="text" class="button" id="dirname" name="dirname" value="${directory}">
            <input type="submit" class="button" id="data" value="${Submit}">
        </div>
    </form>
    <form class="myForm2" action="#" method="post" name="creating a directory">
        <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span>
        <div class="container">
            <p>${Folder}</p>
        </div>
        <div class="input">
            <input type="text" class="button" id="filenameD" name="filename" placeholder="Type directory name">
            <input type="text" class="button" id="dirname" name="dirname" value="${directory}">
            <input type="submit" class="button" id="dataD" value="${Submit}">
        </div>
    </form>
    <div id="prompt-form-container">
        <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span>
        <form id="prompt-form">
            <input type="text" id="commentSource">
            <div id="prompt-message"></div>
            <textarea name="text" placeholder="${Comment}" rows="10" cols="40"></textarea>
            <input file="${file.path}" type="submit" value="${Save}" class="save-btn">
        </form>
    </div>

    <div id="edit-form-container">
        <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span>
        <form id="edit-form">
            <input type="text" id="editSource">
            <div id="edit-message"></div>
            <textarea id="textToEdit" name="text" rows="11" cols="70"></textarea>
            <input file="${file.path}" type="submit" value="${Save}" class="saved-btn">
        </form>
    </div>

</body>

</html>

<style type="text/css">
    body {
        background: white;
        font-family: 'Lato', sans-serif;
        color: #737373;
        font-size: 18px;
        text-align: center;
        position: relative;
        z-index: 1;
    }

    .uploadForm {
        width: 45%;
        height: 350px;
        position: absolute;
        top: 12%;
        left: 28%;
        border-radius: 15px;
        opacity: 70%;
        font-size: 22px;
        display: none;
        align-content: center;
        border-style: none;
        background-color: white;
        z-index: 5;
    }

    #r {
        border-style: none;
        font-family: 'Lato', sans-serif;
        color: #737373;
        font-size: 18px;
        width: 3%;
        margin-left: 25%;
        position: absolute;
        background-color: transparent;
        display: none;
    }

    #w {
        border-style: none;
        background-color: transparent;
        font-family: 'Lato', sans-serif;
        color: #737373;
        font-size: 18px;
        width: 3%;
        display: none;
        margin-left: 27%;
        position: absolute;
    }

    .upload {
        opacity: 80%;
        margin-left: 25%;
        border-style: none;
        width: 15%;
        height: 46px;
        background: #cce1f8;
        font-family: 'Roboto', sans-serif;
        font-size: 20px;
        color: #428be5;
        border-radius: 25px;
        cursor: pointer;
        transition: background .3s ease-in-out;
    }

    .uploadD {
        opacity: 80%;
        border-style: none;
        width: 15%;
        height: 46px;
        background: #cce1f8;
        font-family: 'Roboto', sans-serif;
        font-size: 20px;
        color: #428be5;
        border-radius: 25px;
        cursor: pointer;
        transition: background .3s ease-in-out;
    }

    .lang {
        margin-left: 20%;
        opacity: 80%;
        border-style: none;
        width: 5%;
        height: 46px;
        background: #FBEC5D;
        font-family: 'Roboto', sans-serif;
        font-size: 18px;
        color: #737373;
        border-radius: 25px;
        cursor: pointer;
        transition: background .3s ease-in-out;
    }

    .buttonLabel {
        width: 200px;
        height: 45px;
        opacity: 80%;
    }

    .buttonLabel {
        right: 32%;
        top: 50px;
        width: 230px;
        height: 40px;
        font-size: 18px;
        color: #737373;
        text-align: center;
        background-color: white;
        display: inline-block;
        border-radius: 20px;
    }

    .download-btn {
        left: 3%;
        opacity: 80%;
    }

    .remove-btn {
        opacity: 80%;
    }

    .closebtn {
        margin-left: 10px;
        color: darkgrey;
        font-weight: bold;
        float: right;
        font-size: 28px;
        line-height: 20px;
        cursor: pointer;
        transition: 0.3s;
    }

    .closebtn:hover {
        color: #737373;
    }

    .container {
        border-style: none;
        opacity: 70%;
        font-size: 35px;
        text-transform: uppercase;
        letter-spacing: 5px;
    }

    .input {
        border-style: none;
        opacity: 80%;
        display: block;
        align-items: center;
    }


    .buttonUp {
        height: 44px;
        border: 2px solid;
        border-color: #E86C8D;
        border-radius: 20px;
        font-size: 18px;
        color: #737373;
    }

    .button {
        height: 44px;
        border-color: #428be5;
        border-radius: 20px;
        font-size: 18px;
        color: white;
    }

    .myForm2 {
        border-style: none;
        width: 45%;
        height: 300px;
        position: absolute;
        top: 15%;
        left: 28%;
        border-radius: 15px;
        opacity: 80%;
        display: none;
        align-content: center;
        background-color: white;
        z-index: 5;

    }


    .myForm {
        border-style: none;
        width: 45%;
        height: 300px;
        position: absolute;
        top: 15%;
        left: 28%;
        border-radius: 15px;
        opacity: 80%;
        display: none;
        align-content: center;
        background-color: white;
        z-index: 5;

    }

    #filename {
        width: 75%;
        background: white;
        font-family: inherit;
        color: #737373;
        letter-spacing: 1px;
        text-indent: 5%;
        border-radius: 10px;
    }

    #filenameD {
        width: 75%;
        background: white;
        font-family: inherit;
        color: #737373;
        letter-spacing: 1px;
        text-indent: 5%;
        border-radius: 10px;
    }

    #commentSource {
        width: 100%;
        background: white;
        font-family: inherit;
        font-size: 22px;
        color: #428be5;
        opacity: 80%;
        border-style: none;
    }

    #editSource {
        width: 80%;
        top: 10%;
        background: white;
        font-family: inherit;
        font-size: 22px;
        color: #428be5;
        opacity: 80%;
        border-style: none;
    }

    #dirname {
        width: 75%;
        background: white;
        font-family: inherit;
        color: #737373;
        letter-spacing: 1px;
        text-indent: 5%;
        border-radius: 10px;
    }

    .save-btn {
        border-style: none;
        position: absolute;
        top: 85%;
        left: 40%;
        width: 15%;
        height: 30px;
        background: #428be5;
        font-family: 'Roboto', sans-serif;
        font-size: 16px;
        color: white;
        border-radius: 15px;
        cursor: pointer;
        transition: background .3s ease-in-out;
    }

    .saved-btn {
        border-style: none;
        position: absolute;
        top: 85%;
        left: 40%;
        width: 15%;
        height: 30px;
        background: #428be5;
        font-family: 'Roboto', sans-serif;
        font-size: 16px;
        color: white;
        border-radius: 15px;
        cursor: pointer;
        transition: background .3s ease-in-out;
    }

    .note-btn {
        border-style: none;
        left: 8%;
        width: 7%;
        height: 25px;
        background: white;
        font-family: inherit;
        color: #428be5;
        border-color: #cce1f8;
        border-radius: 15px;
        cursor: pointer;
        transition: background .3s ease-in-out;
    }

    #prompt-form-container {
        width: 45%;
        height: 400px;
        position: absolute;
        top: 10%;
        left: 28%;
        border-radius: 15px;
        opacity: 70%;
        display: none;
        align-content: center;
        border-style: none;
        background-color: white;
        z-index: 5;
    }

    #edit-form-container {
        width: 65%;
        height: 450px;
        position: absolute;
        top: 15%;
        left: 20%;
        border-radius: 15px;
        opacity: 80%;
        display: none;
        align-content: center;
        border-style: none;
        opacity: 80%;
        background-color: white;
        z-index: 5;
    }

    #prompt-form {
        display: block;
        margin: 10px;
        width: 380px;
    }

    #edit-form {
        display: block;
        margin: 10px;
        width: 380px;
    }

    textarea {
        font-family: 'Roboto', sans-serif;
        border-style: none;
        color: #737373;
        border-color: transparent;
        overflow: auto;
        position: absolute;
        top: 15%;
        left: 15%;
        padding: 10px;
        font-size: 16px;
        line-height: 1.5;
        border-radius: 5px;
    }

    .create-btn {
        opacity: 80%;
        border-style: none;
        width: 15%;
        height: 46px;
        background: #428be5;
        font-family: 'Roboto', sans-serif;
        font-size: 20px;
        color: white;
        border-radius: 25px;
        cursor: pointer;
        transition: background .3s ease-in-out;
    }

    #dataUpload {
        border-style: none;
        width: 25%;
        height: 46px;
        position: absolute;
        top: 250px;
        right: 35%;
        background: #428be5;
        font-family: inherit;
        font-weight: bold;
        color: white;
        letter-spacing: 1px;
        border-radius: 25px;
        cursor: pointer;
        transition: background .3s ease-in-out;
    }

    #data {
        border-style: none;
        width: 25%;
        height: 46px;
        position: absolute;
        top: 230px;
        right: 35%;
        background: #428be5;
        font-family: inherit;
        font-weight: bold;
        color: white;
        letter-spacing: 1px;
        border-radius: 25px;
        cursor: pointer;
        transition: background .3s ease-in-out;
    }

    #dataD {
        border-style: none;
        width: 25%;
        height: 46px;
        position: absolute;
        top: 230px;
        right: 35%;
        background: #428be5;
        font-family: inherit;
        font-weight: bold;
        color: white;
        letter-spacing: 1px;
        border-radius: 25px;
        cursor: pointer;
        transition: background .3s ease-in-out;
    }

    .create-btn:hover {
        background: #FBEC5D;
        border-radius: 20px;
        color: #737373;
    }

    #dataUpload:hover {
        background: #FBEC5D;
        border-radius: 20px;
        color: #737373;
    }

    .upload:hover {
        background: #FBEC5D;
        border-radius: 20px;
        color: #737373;
    }

    .uploadD:hover {
        background: #FBEC5D;
        border-radius: 20px;
        color: #737373;
    }

    .lang:hover {
        background: #428be5;
        border-radius: 20px;
        color: white;
    }

    .saved-btn:hover {
        background: #FBEC5D;
        border-radius: 20px;
        color: #737373;
    }

    .save-btn:hover {
        background: #FBEC5D;
        border-radius: 20px;
        color: #737373;
    }

    #data:hover {
        background: #FBEC5D;
        border-radius: 20px;
        color: #737373;
    }

    #dataD:hover {
        background: #FBEC5D;
        border-radius: 20px;
        color: #737373;
    }

    #filename:hover {
        background: #FBEC5D;
        border-radius: 25px;
        color: #737373;
        border: none;
    }

    #filenameD:hover {
        background: #FBEC5D;
        border-radius: 25px;
        color: #737373;
        border: none;
    }


    #dirname:hover {
        background: #FBEC5D;
        border-radius: 25px;
        color: #737373;
        border: none;
    }

    .border {
        list-style: none;
        padding: 0;
    }

    .border li {
        font-family: 'Lato', sans-serif;
        ;
        padding: 7px 20px;
        margin-bottom: 10px;
        border-radius: 5px;
        border-left: 10px solid #737373;
        box-shadow: 2px -2px 5px 0 rgba(0, 0, 0, .1),
            -2px -2px 5px 0 rgba(0, 0, 0, .1),
            2px 2px 5px 0 rgba(0, 0, 0, .1),
            -2px 2px 5px 0 rgba(0, 0, 0, .1);
        font-size: 20px;
        letter-spacing: 2px;
        transition: 0.3s all linear;
    }

    .border li:nth-child(2) {
        border-color: #8bc63e;
    }

    .border li:nth-child(3) {
        border-color: #fcba30;
    }

    .border li:nth-child(4) {
        border-color: #1ccfc9;
    }

    .border li:nth-child(5) {
        border-color: #493224;
    }

    .border li:hover {
        border-left: 10px solid transparent;
    }

    .border li:nth-child(1):hover {
        border-right: 10px solid #737373;
    }

    .border li:nth-child(2):hover {
        border-right: 10px solid #8bc63e;
    }

    .border li:nth-child(3):hover {
        border-right: 10px solid #fcba30;
    }

    .border li:nth-child(4):hover {
        border-right: 10px solid #1ccfc9;
    }

    .border li:nth-child(5):hover {
        border-right: 10px solid #493224;
    }


    .pathborder {
        list-style: none;
        padding: 0;
    }

    .pathborder {
        list-style: none;
        padding: 0;
    }

    .pathborder li {
        font-family: 'Lato', sans-serif;
        ;
        padding: 7px 20px;
        margin-bottom: 10px;
        border-radius: 5px;
        border-left: 10px solid #FBEC5D;
        box-shadow: 2px -2px 5px 0 rgba(0, 0, 0, .1),
            -2px -2px 5px 0 rgba(0, 0, 0, .1),
            2px 2px 5px 0 rgba(0, 0, 0, .1),
            -2px 2px 5px 0 rgba(0, 0, 0, .1);
        font-size: 20px;
        letter-spacing: 2px;
        transition: 0.3s all linear;
    }

    .pathborder li:nth-child(2) {
        border-color: #8bc63e;
    }

    .pathborder li:nth-child(3) {
        border-color: #fcba30;
    }

    .pathborder li:nth-child(4) {
        border-color: #1ccfc9;
    }

    .pathborder li:nth-child(5) {
        border-color: #493224;
    }

    .pathborder li:hover {
        border-left: 10px solid transparent;
    }

    .pathborder li:nth-child(1):hover {
        border-right: 10px solid #FBEC5D;
    }

    .pathborder li:nth-child(2):hover {
        border-right: 10px solid #8bc63e;
    }

    .pathborder li:nth-child(3):hover {
        border-right: 10px solid #fcba30;
    }

    .pathborder li:nth-child(4):hover {
        border-right: 10px solid #1ccfc9;
    }

    .pathborder li:nth-child(5):hover {
        border-right: 10px solid #493224;
    }

    .dirborder {
        list-style: none;
        padding: 0;
    }

    .dirborder li {
        font-family: 'Lato', sans-serif;
        padding: 7px 20px;
        margin-bottom: 10px;
        border-radius: 5px;
        border-left: 10px solid #cce1f8;
        box-shadow: 2px -2px 5px 0 rgba(0, 0, 0, .1),
            -2px -2px 5px 0 rgba(0, 0, 0, .1),
            2px 2px 5px 0 rgba(0, 0, 0, .1),
            -2px 2px 5px 0 rgba(0, 0, 0, .1);
        font-size: 20px;
        letter-spacing: 2px;
        transition: 0.3s all linear;
    }

    .dirborder li:nth-child(1):hover {
        border-right: 10px solid #cce1f8;
    }

</style>
<script>
    $(document).ready(function() {
        $(".remove-btn").click(function() {
            var answer = confirm("Do you want to delete the file?");
            if (answer == true) {
                var file = this.attributes.file.nodeValue;
                $.ajax({
                    url: "/remove",
                    type: "get",
                    data: {
                        'file': file
                    },
                    success: function(response) {
                        location.reload();

                    }
                });
            }
        });
    });

    $(document).ready(function() {
        $(".download-btn").click(function() {
            var answer = confirm("Do you want to download the file?");
            if (answer == true) {
                var file = this.attributes.file.nodeValue;
                window.location.href = "/download?fileName=" + file;
            }
        });
    });

    var createFile = function(directory, fileName, isRead, isWrite, isEx) {
        $.ajax({
            url: "/create",
            type: "post",
            data: {
                'newFile': directory + "/" + fileName,
                'isRead': isRead,
                'isWrite': isWrite,
                'isEx': isEx
            },
            success: function(response) {
                location.reload();
                if (isRead == true && isWrite != true) {
                    alert(
                        "This file is readable only."
                    )
                }
                if (isRead != true && isWrite == true) {
                    alert(
                        "This file is writable only."
                    )
                }
                if (isRead != true && isWrite != true) {
                    alert(
                        "You can't read or write this file."
                    )
                }
            }
        });
    }

    var createDirectory = function(directory, dirName) {
        $.ajax({
            url: "/createDir",
            type: "post",
            data: {
                'pathD': directory + "/" + dirName
            },
            success: function(response) {
                location.reload();
            }
        });
    }

    var createComment = function(value, path) {
        $.ajax({
            url: "/create-comment",
            type: "post",
            data: {
                'path': path,
                'comment': value
            },
            success: function(response) {
                location.reload();
            }
        });
    }

    var resolveComment = function(path, callback) {
        $.ajax({
            url: "/resolve-comment",
            type: "get",
            data: {
                'path': path
            },
            success: callback
        });
    }

    $(document).ready(function() {
        $(".save-btn").click(function() {
            var comment = $('textarea').val();
            var filePath = $('#commentSource').val();
            createComment(comment, filePath);
            $("#prompt-form-container").hide();
            return false;
        });
    });


    $(document).ready(function() {
        $(".create-btn").click(function() {
            $(".myForm").show();
        });
    });

    $(document).ready(function() {
        $(".uploadD").click(function() {
            $(".myForm2").show();
        });
    });

    $(document).ready(function() {
        $("#data").click(function() {
            var fileName = $('#filename').val();
            var directory = $('#dirname').val();
            var isRead = document.getElementById("read").checked;
            var isWrite = document.getElementById("write").checked;
            var isEx = true;
            createFile(directory, fileName, isRead, isWrite, isEx);
            return false;
        });
    });
    $(document).ready(function() {
        $("li").click(function() {
            var read = document.getElementsById("r");
            var directory = $('#dirname').val();
            var isRead = document.getElementById("read").checked;
            var isWrite = document.getElementById("write").checked;
            var isEx = true;
            createFile(directory, fileName, isRead, isWrite, isEx);
            return false;
        });
    });


    $(document).ready(function() {
        $("#dataD").click(function() {
            var dirName = $('#filenameD').val();
            var directory = $('#dirname').val();
            createDirectory(directory, dirName);
            return false;
        });
    });

    $(document).ready(function() {
        $(".upload").click(function() {
            $(".uploadForm").show();
        });
    });

    function showPrompt(filePath) {
        let form = document.getElementById('prompt-form');
        let container = document.getElementById('prompt-form-container');


        resolveComment(filePath, function(comment) {
            $('textarea').val(comment);
        });
        $('#commentSource').val(filePath);
        container.style.display = 'block';
        form.elements.text.focus();
    };


    $(document).ready(function() {
        $(".note-btn").click(function() {
            showPrompt(this.attributes.file.nodeValue);
        });
    });


    var saveText = function(path, text) {
        $.ajax({
            url: "/save-text",
            type: "post",
            data: {
                'fileName': path,
                'text': text
            },
            success: function(response) {
                location.reload();
            }
        });
    }


    var editText = function(path, callback) {
        $.ajax({
            url: "/edit-text",
            type: "post",
            data: {
                'fileName': path
            },
            success: callback
        });
    }

    $(document).ready(function() {
        $('#textToEdit').change(function() {
            var text = $('#textToEdit').val();
            var fileName = $('#editSource').val();
            saveText(text, fileName);
        });
        $(".saved-btn").click(function() {
            var text = $('#textToEdit').val();
            var fileName = $('#editSource').val();
            saveText(text, fileName);
            $("#edit-form-container").hide();
            return false;
        });
    });

    function showEdit(fileName) {
        let form = document.getElementById('edit-form');
        let container = document.getElementById('edit-form-container');


        editText(fileName, function(text) {
            $('#textToEdit').val(text);
        });
        $('#editSource').val(fileName);
        container.style.display = 'block';
        form.elements.text.focus();
    };

    $(document).ready(function() {
        $(".edit-btn").click(function() {
            showEdit(this.attributes.file.nodeValue);
        });
    });

</script>
