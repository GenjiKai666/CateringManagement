<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="keywords" content="">
    <meta name="description" content="">

    <title>Restaurant</title>

    <!-- Loading Bootstrap -->
    <link href="static/css/bootstrap.css" rel="stylesheet">

    <!-- Loading Template CSS -->
    <link href="static/css/style.css" rel="stylesheet">
    <link href="static/css/animate.css" rel="stylesheet">
    <link href="static/css/style-magnific-popup.css" rel="stylesheet">

    <!-- Fonts -->
    <link href="static/css/font-awesome.min.css" rel="stylesheet">
    <link href="static/css/icons-main.css" rel="stylesheet">
    <link href="static/css/icons-helper.css" rel="stylesheet">

    <!-- RS5.0 Main Stylesheet -->
    <link rel="stylesheet" type="text/css" href="static/css/settings.css">

    <!-- RS5.0 Layers and Navigation Styles -->
    <link rel="stylesheet" type="text/css" href="static/css/layers.css">
    <link rel="stylesheet" type="text/css" href="static/css/navigation.css">

    <!-- Google Fonts -->
    <link href='static/css/css.css' rel='stylesheet' type='text/css'>
    <link href='static/css/css1.css' rel='stylesheet' type='text/css'>
    <link href='static/css/css2.css' rel='stylesheet' type='text/css'>

    <!-- Font Favicon -->


    <!-- HTML5 shim, for IE6-8 support of HTML5 elements. All other JS at the end of file. -->
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->

    <!--headerIncludes-->
</head>
<body>

<!--begin header -->
<header class="header">

    <!--begin nav -->
    <nav class="navbar navbar-default navbar-fixed-top">

        <!--begin container -->
        <div class="container">

            <!--begin navbar -->
            <div class="navbar-header">
                <button data-target="#navbar-collapse-02" data-toggle="collapse" class="navbar-toggle" type="button">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>

                <a href="index.html" class="navbar-brand brand scrool"><img src="static/picture/logo.png"
                                                                            alt="logo"></a>
            </div>

            <div id="navbar-collapse-02" class="collapse navbar-collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="index.html">Home</a></li>
                    <li><a href="about.html">About Us</a></li>
                    <li class="selected"><a href="">Menu</a></li>
                    <li><a href="order.html">Dishes Order</a></li> <!--跳转到以点订单-->
                    <li><a href="gallery.html">Gallery</a></li>
                    <li><a href="contact.html">Contact</a></li>
                    <li class="social"><a href="#" class="first"><i class="fa fa-twitter"></i></a></li>
                    <li class="social"><a href="#"><i class="fa fa-facebook"></i></a></li>
                    <li class="social"><a href="#" class="last"><i class="fa fa-instagram"></i></a></li>
                    <li><a href="openTable.jsp" class="purchase">OPEN A TABLE</a></li> <!--开台-->
                </ul>
            </div>
            <!--end navbar -->

        </div>
        <!--end container -->

    </nav>
    <!--end nav -->

</header>
<!--end header -->

<!--begin menu-hero-section -->
<section id="hero-section" class="menu-hero-section">

    <!--begin image-overlay -->
    <div class="image-overlay"></div>
    <!--end image-overlay -->

    <!--begin container-->
    <div class="container image-section-inside">

        <!--begin row-->
        <div class="row">

            <!--begin col-md-10-->
            <div class="col-md-10 col-md-offset-1 text-center">

                <span class="comic-text white wow fadeIn" data-wow-delay="0.5s">Our Menu</span>

                <h2 class="section-title white wow bounceIn" data-wow-delay="1s">Food &amp; Drinks</h2>

                <p class="hero-text wow fadeInUp" data-wow-delay="2s">An unforgettable dining experience in the heart of
                    Covent Garden, London.<br>
                    Contemporary british menu, inspired by the traditions of Great Britain.</p>

            </div>
            <!--end col-md-10-->

        </div>
        <!--end row-->

    </div>
    <!--end container-->

</section>
<!--end menu-hero-section -->


<!--begin first-menu-section -->
<section class="section-white">

    <!--begin container-->
    <div class="container">

        <c:forEach var="i" begin="0" end="${fn:length(requestScope.typeList)-1}" step="2">
            <!--开始一行（每一行里面有两个菜品类别）-->
            <div class="row">

                <!--左边的菜品类别-->
                <div class="col-md-6">
                    <h2 class="menu-section-title">${requestScope.typeList.get(i).name}</h2>
                    <c:forEach var="dish" items="${requestScope.dishMap.get(requestScope.typeList.get(i).id)}"
                               varStatus="status">
                        <!--开始一个菜-->
                        <div class="menu-wrapper">

                            <!--begin menu-image-->
                            <div class="menu-image"> <!--图片-->
                                <a href="#"><img src="static/picture/${dish.id}picture.jpg" class="width-100"
                                                 alt="food"></a>

                            </div>
                            <!--end menu-image-->

                            <!--begin menu-description -->
                            <div class="menu-description">

                                <!--begin menu-list-->
                                <div class="menu-list">

                                    <h5>${dish.dishName}</h5> <!--菜品名称-->

                                    <p class="price">${dish.price}</p><!--价格-->

                                    <span class="menu-dot-line"></span>

                                </div>
                                <!--end menu-list-->
                                <!--详情-->
                                <p class="menu-ingredients">Scrambled eggs with crispy bacon</p>
                                <!--点餐按钮-->
                                <button id=${dish.id} onclick="add(id)">+</button>
                                <c:set var="idshow" value="${dish.id}show"/>
                                <input type="text" readonly="true" style="width:18px" value="0" id=${idshow}><%--20--%>
                                <button id=${dish.id} onclick="sub(id)">-</button>
                            </div>
                            <!--end menu-description-->

                        </div>
                        <!--结束一个菜-->
                    </c:forEach>
                </div>
                <!--结束左边的菜品类别-->

                    <%--如果i<${fn:length(requestScope.typeList)}-1，才能进行下列操作--%>
                <c:if test="${i<fn:length(requestScope.typeList)-1}">
                    <!--右边的菜品类别-->
                    <div class="col-md-6">
                        <h2 class="menu-section-title">${requestScope.typeList.get(i+1).name}</h2>
                        <c:forEach var="dish" items="${requestScope.dishMap.get(requestScope.typeList.get(i+1).id)}"
                                   varStatus="status">
                            <!--开始一个菜-->
                            <div class="menu-wrapper">

                                <!--begin menu-image-->
                                <div class="menu-image"> <!--图片-->
                                        <%--图片在picture文件夹下，路径为static/picture/编号+picture.jpg--%>
                                    <a href="#"><img src="static/picture/${dish.id}picture.jpg" class="width-100"
                                                     alt="food"></a>

                                </div>
                                <!--end menu-image-->

                                <!--begin menu-description -->
                                <div class="menu-description">

                                    <!--begin menu-list-->
                                    <div class="menu-list">

                                        <h5>${dish.dishName}</h5> <!--菜品名称-->

                                        <p class="price">${dish.price}</p><!--价格-->

                                        <span class="menu-dot-line"></span>

                                    </div>
                                    <!--end menu-list-->
                                    <!--详情-->
                                    <p class="menu-ingredients">Scrambled eggs with crispy bacon</p>
                                    <!--点餐按钮-->
                                    <button id=${dish.id} onclick="add(id)">+</button>
                                    <c:set var="idshow" value="${dish.id}show"/>
                                    <input type="text" readonly="true" style="width:18px" value="0" id=${idshow}><%--20--%>
                                    <button id=${dish.id} onclick="sub(id)">-</button>
                                </div>
                                <!--end menu-description-->

                            </div>
                            <!--结束一个菜-->
                        </c:forEach>
                    </div>
                    <!--结束右边的菜品类别-->
                </c:if>
            </div>
            <!--结束一行-->

        </c:forEach>

        <%--提交按钮--%>
        <input value="Submit Order" id="submit-button" class="register-submit" type="submit" onclick="f1()">

        <%--script--%>
        <script type="text/javascript">
            function add(id) {
                let result = document.getElementById(id + "show");
                result.value = parseInt(result.value) + 1;
            }

            function sub(id) {
                let result = document.getElementById(id + "show");
                if (result.value > 0)
                    result.value = parseInt(result.value) - 1;
            }


            function f1() {
                <%--console.log("dishList_0_name：" + "${requestScope.dishList[0].dishName}");--%>
                <%--console.log("length：" +${fn:length(dishList)});--%>
                //读出dish.id之后根据id找到对应的按钮，将按钮的值放入list中，传给后端
                var list = [];
                <c:forEach var="type" items="${requestScope.typeList}" varStatus="status">
                <c:forEach var="dish" items="${requestScope.dishMap.get(type.id)}" varStatus="status">
                var index = "${dish.id}";
                var number = document.getElementById("${dish.id}" + "show").value;
                if (number == "choose")
                    number = "0";
                console.log("index:" + index + "number:" + number); //index:菜品编号，number:菜品数量
                list.push({index: index, number: number});
                /*提交订单后恢复0*/
                document.getElementById("${dish.id}" + "show").value = "0"
                </c:forEach>
                </c:forEach>
                console.log(JSON.stringify(list));
                axios({
                    method: "post",
                    url: "/order",
                    data: JSON.stringify(list),
                    headers: {
                        'Content-Type': 'application/json'
                    }
                }).then(res => {
                    console.log(res.data);
                    alert("您的订单已提交成功");
                })
                /*axios({
                    method: 'post',
                    url: '/order',
                    data: JSON.stringify({
                        test1:'123',
                        test2:'123123'
                    }),
                    header: {
                        'Content-Type': "application/json"
                    }
                }).then((res) => {
                    console.log(res.data);
                    alert("您的订单已提交成功");
                });*/
                /*var userList = [];
                userList.push({username: "zhangsan", age: 18});
                userList.push({username: "lisi", age: 28});
                console.log(JSON.stringify(userList));
                console.log(typeof JSON.stringify(userList)); //String
                axios.post("/order",JSON.stringify(userList))
                    .then((res) => {
                    console.log(res.data);
                    alert("您的订单已提交成功");
                });*/
                /*axios.post("/order",map)
                    .then((res)=>{
                        console.log(res.data);
                        alert("您的订单已提交成功");
                    })*/
            }
        </script>

    </div>
    <!--end container-->

</section>
<!--end first-menu-section -->


<!--begin home-menu-section -->
<section class="home-menu-section">

    <!--begin image-overlay -->
    <div class="image-overlay"></div>
    <!--end image-overlay -->

    <!--begin container-->
    <div class="container image-section-inside">

        <!--begin row-->
        <div class="row">

            <!--begin col-md-7-->
            <div class="col-md-7">

                <div class="text-center margin-bottom-30">

                    <span class="comic-text">Best Recipes</span>

                    <h3 class="section-title white">AWARDED CHEFS</h3>

                </div>

                <!--begin row-->
                <div class="row">

                    <!--begin col-md-6-->
                    <div class="col-md-6">

                        <!--begin menu-wrapper-->
                        <div class="menu-wrapper">

                            <!--begin home-menu-list-->
                            <div class="home-menu-list">

                                <h5 class="white">English Breakfast</h5>

                                <p class="price">$12.95</p>

                                <span class="dot-line"></span>

                            </div>
                            <!--end home-menu-list-->

                            <p class="home-menu-ingredients">Scrambled eggs with crispy bacon, sausage, black pudding,
                                tomato &amp; mushroom.</p>

                        </div>
                        <!--end menu-wrapper-->

                    </div>
                    <!--end col-md-6-->

                    <!--begin col-md-6-->
                    <div class="col-md-6">

                        <!--begin menu-wrapper-->
                        <div class="menu-wrapper">

                            <!--begin home-menu-list-->
                            <div class="home-menu-list">

                                <h5 class="white">Lasagna Classica</h5>

                                <p class="price">$19.55</p>

                                <span class="dot-line"></span>

                            </div>
                            <!--end home-menu-list-->

                            <p class="home-menu-ingredients">Broccoli rabe, ittalian sausage, peperoncino, tomates,
                                flour and roasted garlic.</p>

                        </div>
                        <!--end menu-wrapper-->

                    </div>
                    <!--end col-md-6-->

                    <!--begin col-md-6-->
                    <div class="col-md-6">

                        <!--begin menu-wrapper-->
                        <div class="menu-wrapper">

                            <!--begin home-menu-list-->
                            <div class="home-menu-list">

                                <h5 class="white">Vegetables Soup</h5>

                                <p class="price">$9.95</p>

                                <span class="dot-line"></span>

                            </div>
                            <!--end home-menu-list-->

                            <p class="home-menu-ingredients">Papaya salsa, sliced red radishes, avocado, corn tortilla,
                                spicy tomato ketchup.</p>

                        </div>
                        <!--end menu-wrapper-->

                    </div>
                    <!--end col-md-6-->

                    <!--begin col-md-6-->
                    <div class="col-md-6">

                        <!--begin menu-wrapper-->
                        <div class="menu-wrapper">

                            <!--begin home-menu-list-->
                            <div class="home-menu-list">

                                <h5 class="white">Toffee Pudding</h5>

                                <p class="price">$10.50</p>

                                <span class="dot-line"></span>

                            </div>
                            <!--end home-menu-list-->

                            <p class="home-menu-ingredients">Baked caramel colored sponge cake with raisins, ladled with
                                warm toffee sauce.</p>

                        </div>
                        <!--end menu-wrapper-->

                    </div>
                    <!--end col-md-6-->

                </div>
                <!--end row-->

                <!--begin row-->
                <div class="row text-center margin-top-20">

                    <a href="#" class="btn btn-lg btn-white-transparent scrool"><i class="pe-7s-gift"
                                                                                   style="font-size:20px; float: left; margin-top:-4px; margin-right: 10px; color: #f8bf2c;"></i>FULL
                        MENU</a>

                </div>
                <!--end row-->

            </div>
            <!--end col-md-7-->

        </div>
        <!--end row-->

    </div>
    <!--end container-->

</section>
<!--end home-menu-section -->


<!--begin slideshow section -->
<section class="section-white no-padding-bottom">

    <!--begin container-->
    <div class="container">

        <!--begin row-->
        <div class="row">

            <!--begin col-md-12-->
            <div class="col-md-12 text-center">

                <div class="text-center">

                    <span class="comic-text">Chef's Pick</span>

                    <h2 class="section-title no-margin">Cooking Recipes</h2>

                </div>

            </div>
            <!--end col-md-12-->

        </div>
        <!--end row-->

        <!--begin row-->
        <div class="row">

            <!--begin col-md-12-->
            <div class="col-md-12 text-center">

                <!--begin rev_slider_108_1_wrapper-->
                <div id="rev_slider_108_1_wrapper" class="rev_slider_wrapper fullwidthbanner-container"
                     data-alias="food-carousel80" style="margin:0px auto;padding:0px;margin-top:0px;margin-bottom:0px;">

                    <!-- START REVOLUTION SLIDER 5.0.7 fullwidth mode -->
                    <div id="rev_slider_108_1" class="rev_slider fullwidthabanner" style="display:none;"
                         data-version="5.0.7">

                        <ul>

                            <!-- SLIDE  -->
                            <li data-index="rs-326" data-transition="fade" data-slotamount="7" data-easein="default"
                                data-easeout="default" data-masterspeed="300"
                                data-thumb="images/rs-images/food0-150x100.jpg" data-rotate="0"
                                data-saveperformance="off" data-title="Spicy Chili Soup" data-description="">
                                <!-- MAIN IMAGE -->
                                <img src="static/picture/food0.jpg" alt="" data-bgposition="center center"
                                     data-bgfit="contain" data-bgrepeat="no-repeat" class="rev-slidebg"
                                     data-no-retina="">
                                <!-- LAYERS -->

                                <!-- LAYER NR. 1 -->
                                <div class="tp-caption FoodCarousel-Content   tp-resizeme" id="slide-326-layer-3"
                                     data-x="center" data-hoffset="" data-y="center" data-voffset=""
                                     data-width="['420']" data-height="['420']" data-transform_idle="o:1;"
                                     data-transform_in="z:0;rX:0;rY:0;rZ:0;sX:0.9;sY:0.9;skX:0;skY:0;opacity:0;s:800;e:Power3.easeInOut;"
                                     data-transform_out="auto:auto;s:500;" data-start="bytrigger" data-splitin="none"
                                     data-splitout="none" data-responsive_offset="on" data-end="bytrigger"
                                     data-lasttriggerstate="reset"
                                     style="z-index: 5; min-width: 420px; max-width: 420px; max-width: 420px; max-width: 420px; white-space: normal;">
                                    <span class="foodcarousel-headline"
                                          style=" color: #252525; font-weight:700; text-decoration: underline;">Strawberry Cheesecake</span><br>
                                    1 / 2 Cup of Mixed Herbs<br>
                                    2 Pieces of Baguette<br>
                                    3 Large Tomatoes<br>
                                    4 Fresh Salads<br>
                                    1 Red Chili
                                    <hr style="border-top: 1px solid #292e31;">
                                    Quis autem velis et reprehender etims quiste<br>voluptate velit esse quam nihil etsa
                                    illum sit sedit consequatur quias voluptas nets.
                                </div>

                                <!-- LAYER NR. 2 -->
                                <div class="tp-caption FoodCarousel-Button rev-btn " id="slide-326-layer-1"
                                     data-x="center" data-hoffset="" data-y="bottom" data-voffset="50"
                                     data-width="['auto']" data-height="['auto']" data-transform_idle="o:1;"
                                     data-transform_hover="o:1;rX:0;rY:0;rZ:0;z:0;s:300;e:Power1.easeInOut;"
                                     data-style_hover="c:rgba(255, 255, 255, 1.00);bg:rgba(41, 46, 49, 1.00);cursor:pointer;"
                                     data-transform_in="opacity:0;s:300;e:Power3.easeInOut;"
                                     data-transform_out="opacity:0;s:300;s:300;" data-start="0" data-splitin="none"
                                     data-splitout="none"
                                     data-actions='[{"event":"click","action":"startlayer","layer":"slide-326-layer-3","delay":""},{"event":"click","action":"startlayer","layer":"slide-326-layer-5","delay":"200"},{"event":"click","action":"stoplayer","layer":"slide-326-layer-1","delay":""}]'
                                     data-responsive_offset="on" data-responsive="off" data-lasttriggerstate="reset"
                                     style="z-index: 6; white-space: nowrap;outline:none;box-shadow:none;box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;">
                                    <i class="pe-7s-note2"
                                       style="font-size: 21px; float: left;margin-top:-6px;margin-right:10px;"></i> VIEW
                                    RECIPE
                                </div>

                                <!-- LAYER NR. 3 -->
                                <div class="tp-caption FoodCarousel-CloseButton rev-btn  tp-resizeme"
                                     id="slide-326-layer-5" data-x="441" data-y="110" data-width="['auto']"
                                     data-height="['auto']" data-transform_idle="o:1;"
                                     data-transform_hover="o:1;rX:0;rY:0;rZ:0;z:0;s:300;e:Power1.easeInOut;"
                                     data-style_hover="c:rgba(255, 255, 255, 1.00);bg:rgba(41, 46, 49, 1.00);cursor:pointer;"
                                     data-transform_in="z:0;rX:0;rY:0;rZ:0;sX:0.9;sY:0.9;skX:0;skY:0;opacity:0;s:800;e:Power3.easeInOut;"
                                     data-transform_out="auto:auto;s:500;" data-start="bytrigger" data-splitin="none"
                                     data-splitout="none"
                                     data-actions='[{"event":"click","action":"stoplayer","layer":"slide-326-layer-3","delay":""},{"event":"click","action":"stoplayer","layer":"slide-326-layer-5","delay":""},{"event":"click","action":"startlayer","layer":"slide-326-layer-1","delay":""}]'
                                     data-responsive_offset="on" data-end="bytrigger" data-lasttriggerstate="reset"
                                     style="z-index: 7; white-space: nowrap;outline:none;box-shadow:none;box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;">
                                    <i class="fa fa-remove"></i>
                                </div>

                            </li>

                            <!-- SLIDE  -->
                            <li data-index="rs-327" data-transition="fade" data-slotamount="7" data-easein="default"
                                data-easeout="default" data-masterspeed="300"
                                data-thumb="images/rs-images/food2-150x100.jpg" data-rotate="0"
                                data-saveperformance="off" data-title="Classic Bolognese" data-description="">

                                <!-- MAIN IMAGE -->
                                <img src="static/picture/food21.jpg" alt="" data-bgposition="center center"
                                     data-bgfit="contain" data-bgrepeat="no-repeat" class="rev-slidebg"
                                     data-no-retina="">
                                <!-- LAYERS -->

                                <!-- LAYER NR. 1 -->
                                <div class="tp-caption FoodCarousel-Content   tp-resizeme" id="slide-327-layer-3"
                                     data-x="center" data-hoffset="" data-y="center" data-voffset=""
                                     data-width="['420']" data-height="['420']" data-transform_idle="o:1;"
                                     data-transform_in="z:0;rX:0;rY:0;rZ:0;sX:0.9;sY:0.9;skX:0;skY:0;opacity:0;s:800;e:Power3.easeInOut;"
                                     data-transform_out="auto:auto;s:500;" data-start="bytrigger" data-splitin="none"
                                     data-splitout="none" data-responsive_offset="on" data-end="bytrigger"
                                     data-lasttriggerstate="reset"
                                     style="z-index: 5; min-width: 420px; max-width: 420px; max-width: 420px; max-width: 420px; white-space: normal;">
                                    <span class="foodcarousel-headline"
                                          style=" color: #252525; font-weight:700; text-decoration: underline;">Strawberry Cheesecake</span><br>
                                    1 / 2 Cup of Mixed Herbs<br>
                                    2 Pieces of Baguette<br>
                                    3 Large Tomatoes<br>
                                    4 Fresh Salads<br>
                                    1 Red Chili
                                    <hr style="border-top: 1px solid #292e31;">
                                    Quis autem velis et reprehender etims quiste<br>voluptate velit esse quam nihil etsa
                                    illum sit sedit consequatur quias voluptas nets.
                                </div>

                                <!-- LAYER NR. 2 -->
                                <div class="tp-caption FoodCarousel-Button rev-btn " id="slide-327-layer-1"
                                     data-x="center" data-hoffset="" data-y="bottom" data-voffset="50"
                                     data-width="['auto']" data-height="['auto']" data-transform_idle="o:1;"
                                     data-transform_hover="o:1;rX:0;rY:0;rZ:0;z:0;s:300;e:Power1.easeInOut;"
                                     data-style_hover="c:rgba(255, 255, 255, 1.00);bg:rgba(41, 46, 49, 1.00);cursor:pointer;"
                                     data-transform_in="opacity:0;s:300;e:Power3.easeInOut;"
                                     data-transform_out="opacity:0;s:300;s:300;" data-start="0" data-splitin="none"
                                     data-splitout="none"
                                     data-actions='[{"event":"click","action":"startlayer","layer":"slide-327-layer-3","delay":""},{"event":"click","action":"startlayer","layer":"slide-327-layer-5","delay":"200"},{"event":"click","action":"stoplayer","layer":"slide-327-layer-1","delay":""}]'
                                     data-responsive_offset="on" data-responsive="off" data-lasttriggerstate="reset"
                                     style="z-index: 6; white-space: nowrap;outline:none;box-shadow:none;box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;">
                                    <i class="pe-7s-note2"
                                       style="font-size: 21px; float: left;margin-top:-6px;margin-right:10px;"></i> VIEW
                                    RECIPE
                                </div>

                                <!-- LAYER NR. 3 -->
                                <div class="tp-caption FoodCarousel-CloseButton rev-btn  tp-resizeme"
                                     id="slide-327-layer-5" data-x="441" data-y="110" data-width="['auto']"
                                     data-height="['auto']" data-transform_idle="o:1;"
                                     data-transform_hover="o:1;rX:0;rY:0;rZ:0;z:0;s:300;e:Power1.easeInOut;"
                                     data-style_hover="c:rgba(255, 255, 255, 1.00);bg:rgba(41, 46, 49, 1.00);cursor:pointer;"
                                     data-transform_in="z:0;rX:0;rY:0;rZ:0;sX:0.9;sY:0.9;skX:0;skY:0;opacity:0;s:800;e:Power3.easeInOut;"
                                     data-transform_out="auto:auto;s:500;" data-start="bytrigger" data-splitin="none"
                                     data-splitout="none"
                                     data-actions='[{"event":"click","action":"stoplayer","layer":"slide-327-layer-3","delay":""},{"event":"click","action":"stoplayer","layer":"slide-327-layer-5","delay":""},{"event":"click","action":"startlayer","layer":"slide-327-layer-1","delay":""}]'
                                     data-responsive_offset="on" data-end="bytrigger" data-lasttriggerstate="reset"
                                     style="z-index: 7; white-space: nowrap;outline:none;box-shadow:none;box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;">
                                    <i class="fa fa-remove"></i></div>

                            </li>

                            <!-- SLIDE  -->
                            <li data-index="rs-328" data-transition="fade" data-slotamount="7" data-easein="default"
                                data-easeout="default" data-masterspeed="300"
                                data-thumb="images/rs-images/food3-150x100.jpg" data-rotate="0"
                                data-saveperformance="off" data-title="Cottage Cheese &amp; Chives" data-description="">

                                <!-- MAIN IMAGE -->
                                <img src="static/picture/food31.jpg" alt="" data-bgposition="center center"
                                     data-bgfit="contain" data-bgrepeat="no-repeat" class="rev-slidebg"
                                     data-no-retina="">
                                <!-- LAYERS -->

                                <!-- LAYER NR. 1 -->
                                <div class="tp-caption FoodCarousel-Content   tp-resizeme" id="slide-328-layer-3"
                                     data-x="center" data-hoffset="" data-y="center" data-voffset=""
                                     data-width="['420']" data-height="['420']" data-transform_idle="o:1;"
                                     data-transform_in="z:0;rX:0;rY:0;rZ:0;sX:0.9;sY:0.9;skX:0;skY:0;opacity:0;s:800;e:Power3.easeInOut;"
                                     data-transform_out="auto:auto;s:500;" data-start="bytrigger" data-splitin="none"
                                     data-splitout="none" data-responsive_offset="on" data-end="bytrigger"
                                     data-lasttriggerstate="reset"
                                     style="z-index: 5; min-width: 420px; max-width: 420px; max-width: 420px; max-width: 420px; white-space: normal;">
                                    <span class="foodcarousel-headline"
                                          style=" color: #252525; font-weight:700; text-decoration: underline;">Strawberry Cheesecake</span><br>
                                    1 / 2 Cup of Mixed Herbs<br>
                                    2 Pieces of Baguette<br>
                                    3 Large Tomatoes<br>
                                    4 Fresh Salads<br>
                                    1 Red Chili
                                    <hr style="border-top: 1px solid #292e31;">
                                    Quis autem velis et reprehender etims quiste<br>voluptate velit esse quam nihil etsa
                                    illum sit sedit consequatur quias voluptas nets.
                                </div>

                                <!-- LAYER NR. 2 -->
                                <div class="tp-caption FoodCarousel-Button rev-btn " id="slide-328-layer-1"
                                     data-x="center" data-hoffset="" data-y="bottom" data-voffset="50"
                                     data-width="['auto']" data-height="['auto']" data-transform_idle="o:1;"
                                     data-transform_hover="o:1;rX:0;rY:0;rZ:0;z:0;s:300;e:Power1.easeInOut;"
                                     data-style_hover="c:rgba(255, 255, 255, 1.00);bg:rgba(41, 46, 49, 1.00);cursor:pointer;"
                                     data-transform_in="opacity:0;s:300;e:Power3.easeInOut;"
                                     data-transform_out="opacity:0;s:300;s:300;" data-start="0" data-splitin="none"
                                     data-splitout="none"
                                     data-actions='[{"event":"click","action":"startlayer","layer":"slide-328-layer-3","delay":""},{"event":"click","action":"startlayer","layer":"slide-328-layer-5","delay":"200"},{"event":"click","action":"stoplayer","layer":"slide-328-layer-1","delay":""}]'
                                     data-responsive_offset="on" data-responsive="off" data-lasttriggerstate="reset"
                                     style="z-index: 6; white-space: nowrap;outline:none;box-shadow:none;box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;">
                                    <i class="pe-7s-note2"
                                       style="font-size: 21px; float: left;margin-top:-6px;margin-right:10px;"></i> VIEW
                                    RECIPE
                                </div>

                                <!-- LAYER NR. 3 -->
                                <div class="tp-caption FoodCarousel-CloseButton rev-btn  tp-resizeme"
                                     id="slide-328-layer-5" data-x="441" data-y="110" data-width="['auto']"
                                     data-height="['auto']" data-transform_idle="o:1;"
                                     data-transform_hover="o:1;rX:0;rY:0;rZ:0;z:0;s:300;e:Power1.easeInOut;"
                                     data-style_hover="c:rgba(255, 255, 255, 1.00);bg:rgba(41, 46, 49, 1.00);cursor:pointer;"
                                     data-transform_in="z:0;rX:0;rY:0;rZ:0;sX:0.9;sY:0.9;skX:0;skY:0;opacity:0;s:800;e:Power3.easeInOut;"
                                     data-transform_out="auto:auto;s:500;" data-start="bytrigger" data-splitin="none"
                                     data-splitout="none"
                                     data-actions='[{"event":"click","action":"stoplayer","layer":"slide-328-layer-3","delay":""},{"event":"click","action":"stoplayer","layer":"slide-328-layer-5","delay":""},{"event":"click","action":"startlayer","layer":"slide-328-layer-1","delay":""}]'
                                     data-responsive_offset="on" data-end="bytrigger" data-lasttriggerstate="reset"
                                     style="z-index: 7; white-space: nowrap;outline:none;box-shadow:none;box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;">
                                    <i class="fa fa-remove"></i></div>

                            </li>

                            <!-- SLIDE  -->
                            <li data-index="rs-329" data-transition="fade" data-slotamount="7" data-easein="default"
                                data-easeout="default" data-masterspeed="300"
                                data-thumb="images/rs-images/food5-150x100.jpg" data-rotate="0"
                                data-saveperformance="off" data-title="Colorful Salad" data-description="">

                                <!-- MAIN IMAGE -->
                                <img src="static/picture/food51.jpg" alt="" data-bgposition="center center"
                                     data-bgfit="contain" data-bgrepeat="no-repeat" class="rev-slidebg"
                                     data-no-retina="">
                                <!-- LAYERS -->

                                <!-- LAYER NR. 1 -->
                                <div class="tp-caption FoodCarousel-Content   tp-resizeme" id="slide-329-layer-3"
                                     data-x="center" data-hoffset="" data-y="center" data-voffset=""
                                     data-width="['420']" data-height="['420']" data-transform_idle="o:1;"
                                     data-transform_in="z:0;rX:0;rY:0;rZ:0;sX:0.9;sY:0.9;skX:0;skY:0;opacity:0;s:800;e:Power3.easeInOut;"
                                     data-transform_out="auto:auto;s:500;" data-start="bytrigger" data-splitin="none"
                                     data-splitout="none" data-responsive_offset="on" data-end="bytrigger"
                                     data-lasttriggerstate="reset"
                                     style="z-index: 5; min-width: 420px; max-width: 420px; max-width: 420px; max-width: 420px; white-space: normal;">
                                    <span class="foodcarousel-headline"
                                          style=" color: #252525; font-weight:700; text-decoration: underline;">Strawberry Cheesecake</span><br>
                                    1 / 2 Cup of Mixed Herbs<br>
                                    2 Pieces of Baguette<br>
                                    3 Large Tomatoes<br>
                                    4 Fresh Salads<br>
                                    1 Red Chili
                                    <hr style="border-top: 1px solid #292e31;">
                                    Quis autem velis et reprehender etims quiste<br>voluptate velit esse quam nihil etsa
                                    illum sit sedit consequatur quias voluptas nets.
                                </div>

                                <!-- LAYER NR. 2 -->
                                <div class="tp-caption FoodCarousel-Button rev-btn " id="slide-329-layer-1"
                                     data-x="center" data-hoffset="" data-y="bottom" data-voffset="50"
                                     data-width="['auto']" data-height="['auto']" data-transform_idle="o:1;"
                                     data-transform_hover="o:1;rX:0;rY:0;rZ:0;z:0;s:300;e:Power1.easeInOut;"
                                     data-style_hover="c:rgba(255, 255, 255, 1.00);bg:rgba(41, 46, 49, 1.00);cursor:pointer;"
                                     data-transform_in="opacity:0;s:300;e:Power3.easeInOut;"
                                     data-transform_out="opacity:0;s:300;s:300;" data-start="0" data-splitin="none"
                                     data-splitout="none"
                                     data-actions='[{"event":"click","action":"startlayer","layer":"slide-329-layer-3","delay":""},{"event":"click","action":"startlayer","layer":"slide-329-layer-5","delay":"200"},{"event":"click","action":"stoplayer","layer":"slide-329-layer-1","delay":""}]'
                                     data-responsive_offset="on" data-responsive="off" data-lasttriggerstate="reset"
                                     style="z-index: 6; white-space: nowrap;outline:none;box-shadow:none;box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;">
                                    <i class="pe-7s-note2"
                                       style="font-size: 21px; float: left;margin-top:-6px;margin-right:10px;"></i> VIEW
                                    RECIPE
                                </div>

                                <!-- LAYER NR. 3 -->
                                <div class="tp-caption FoodCarousel-CloseButton rev-btn  tp-resizeme"
                                     id="slide-329-layer-5" data-x="441" data-y="110" data-width="['auto']"
                                     data-height="['auto']" data-transform_idle="o:1;"
                                     data-transform_hover="o:1;rX:0;rY:0;rZ:0;z:0;s:300;e:Power1.easeInOut;"
                                     data-style_hover="c:rgba(255, 255, 255, 1.00);bg:rgba(41, 46, 49, 1.00);cursor:pointer;"
                                     data-transform_in="z:0;rX:0;rY:0;rZ:0;sX:0.9;sY:0.9;skX:0;skY:0;opacity:0;s:800;e:Power3.easeInOut;"
                                     data-transform_out="auto:auto;s:500;" data-start="bytrigger" data-splitin="none"
                                     data-splitout="none"
                                     data-actions='[{"event":"click","action":"stoplayer","layer":"slide-329-layer-3","delay":""},{"event":"click","action":"stoplayer","layer":"slide-329-layer-5","delay":""},{"event":"click","action":"startlayer","layer":"slide-329-layer-1","delay":""}]'
                                     data-responsive_offset="on" data-end="bytrigger" data-lasttriggerstate="reset"
                                     style="z-index: 7; white-space: nowrap;outline:none;box-shadow:none;box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;">
                                    <i class="fa fa-remove"></i></div>

                            </li>

                            <!-- SLIDE  -->
                            <li data-index="rs-330" data-transition="fade" data-slotamount="7" data-easein="default"
                                data-easeout="default" data-masterspeed="300"
                                data-thumb="images/rs-images/food4-150x100.jpg" data-rotate="0"
                                data-saveperformance="off" data-title="Its Just Cornflakes" data-description="">

                                <!-- MAIN IMAGE -->
                                <img src="static/picture/food41.jpg" alt="" data-bgposition="center center"
                                     data-bgfit="contain" data-bgrepeat="no-repeat" class="rev-slidebg"
                                     data-no-retina="">
                                <!-- LAYERS -->

                                <!-- LAYER NR. 1 -->
                                <div class="tp-caption FoodCarousel-Content   tp-resizeme" id="slide-330-layer-3"
                                     data-x="center" data-hoffset="" data-y="center" data-voffset=""
                                     data-width="['420']" data-height="['420']" data-transform_idle="o:1;"
                                     data-transform_in="z:0;rX:0;rY:0;rZ:0;sX:0.9;sY:0.9;skX:0;skY:0;opacity:0;s:800;e:Power3.easeInOut;"
                                     data-transform_out="auto:auto;s:500;" data-start="bytrigger" data-splitin="none"
                                     data-splitout="none" data-responsive_offset="on" data-end="bytrigger"
                                     data-lasttriggerstate="reset"
                                     style="z-index: 5; min-width: 420px; max-width: 420px; max-width: 420px; max-width: 420px; white-space: normal;">
                                    <span class="foodcarousel-headline"
                                          style=" color: #252525; font-weight:700; text-decoration: underline;">Strawberry Cheesecake</span><br>
                                    1 / 2 Cup of Mixed Herbs<br>
                                    2 Pieces of Baguette<br>
                                    3 Large Tomatoes<br>
                                    4 Fresh Salads<br>
                                    1 Red Chili
                                    <hr style="border-top: 1px solid #292e31;">
                                    Quis autem velis et reprehender etims quiste<br>voluptate velit esse quam nihil etsa
                                    illum sit sedit consequatur quias voluptas nets.
                                </div>

                                <!-- LAYER NR. 2 -->
                                <div class="tp-caption FoodCarousel-Button rev-btn " id="slide-330-layer-1"
                                     data-x="center" data-hoffset="" data-y="bottom" data-voffset="50"
                                     data-width="['auto']" data-height="['auto']" data-transform_idle="o:1;"
                                     data-transform_hover="o:1;rX:0;rY:0;rZ:0;z:0;s:300;e:Power1.easeInOut;"
                                     data-style_hover="c:rgba(255, 255, 255, 1.00);bg:rgba(41, 46, 49, 1.00);cursor:pointer;"
                                     data-transform_in="opacity:0;s:300;e:Power3.easeInOut;"
                                     data-transform_out="opacity:0;s:300;s:300;" data-start="0" data-splitin="none"
                                     data-splitout="none"
                                     data-actions='[{"event":"click","action":"startlayer","layer":"slide-330-layer-3","delay":""},{"event":"click","action":"startlayer","layer":"slide-330-layer-5","delay":"200"},{"event":"click","action":"stoplayer","layer":"slide-330-layer-1","delay":""}]'
                                     data-responsive_offset="on" data-responsive="off" data-lasttriggerstate="reset"
                                     style="z-index: 6; white-space: nowrap;outline:none;box-shadow:none;box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;">
                                    <i class="pe-7s-note2"
                                       style="font-size: 21px; float: left;margin-top:-6px;margin-right:10px;"></i> VIEW
                                    RECIPE
                                </div>

                                <!-- LAYER NR. 3 -->
                                <div class="tp-caption FoodCarousel-CloseButton rev-btn  tp-resizeme"
                                     id="slide-330-layer-5" data-x="441" data-y="110" data-width="['auto']"
                                     data-height="['auto']" data-transform_idle="o:1;"
                                     data-transform_hover="o:1;rX:0;rY:0;rZ:0;z:0;s:300;e:Power1.easeInOut;"
                                     data-style_hover="c:rgba(255, 255, 255, 1.00);bg:rgba(41, 46, 49, 1.00);cursor:pointer;"
                                     data-transform_in="z:0;rX:0;rY:0;rZ:0;sX:0.9;sY:0.9;skX:0;skY:0;opacity:0;s:800;e:Power3.easeInOut;"
                                     data-transform_out="auto:auto;s:500;" data-start="bytrigger" data-splitin="none"
                                     data-splitout="none"
                                     data-actions='[{"event":"click","action":"stoplayer","layer":"slide-330-layer-3","delay":""},{"event":"click","action":"stoplayer","layer":"slide-330-layer-5","delay":""},{"event":"click","action":"startlayer","layer":"slide-330-layer-1","delay":""}]'
                                     data-responsive_offset="on" data-end="bytrigger" data-lasttriggerstate="reset"
                                     style="z-index: 7; white-space: nowrap;outline:none;box-shadow:none;box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;">
                                    <i class="fa fa-remove"></i></div>

                            </li>

                            <!-- SLIDE  -->
                            <li data-index="rs-331" data-transition="fade" data-slotamount="7" data-easein="default"
                                data-easeout="default" data-masterspeed="300"
                                data-thumb="images/rs-images/food6-150x100.jpg" data-rotate="0"
                                data-saveperformance="off" data-title="Tasty Muesli" data-description="">

                                <!-- MAIN IMAGE -->
                                <img src="static/picture/food6.jpg" alt="" data-bgposition="center center"
                                     data-bgfit="contain" data-bgrepeat="no-repeat" class="rev-slidebg"
                                     data-no-retina="">
                                <!-- LAYERS -->

                                <!-- LAYER NR. 1 -->
                                <div class="tp-caption FoodCarousel-Content   tp-resizeme" id="slide-331-layer-3"
                                     data-x="center" data-hoffset="" data-y="center" data-voffset=""
                                     data-width="['420']" data-height="['420']" data-transform_idle="o:1;"
                                     data-transform_in="z:0;rX:0;rY:0;rZ:0;sX:0.9;sY:0.9;skX:0;skY:0;opacity:0;s:800;e:Power3.easeInOut;"
                                     data-transform_out="auto:auto;s:500;" data-start="bytrigger" data-splitin="none"
                                     data-splitout="none" data-responsive_offset="on" data-end="bytrigger"
                                     data-lasttriggerstate="reset"
                                     style="z-index: 5; min-width: 420px; max-width: 420px; max-width: 420px; max-width: 420px; white-space: normal;">
                                    <span class="foodcarousel-headline"
                                          style=" color: #252525; font-weight:700; text-decoration: underline;">Strawberry Cheesecake</span><br>
                                    1 / 2 Cup of Mixed Herbs<br>
                                    2 Pieces of Baguette<br>
                                    3 Large Tomatoes<br>
                                    4 Fresh Salads<br>
                                    1 Red Chili
                                    <hr style="border-top: 1px solid #292e31;">
                                    Quis autem velis et reprehender etims quiste<br>voluptate velit esse quam nihil etsa
                                    illum sit sedit consequatur quias voluptas nets.
                                </div>

                                <!-- LAYER NR. 2 -->
                                <div class="tp-caption FoodCarousel-Button rev-btn " id="slide-331-layer-1"
                                     data-x="center" data-hoffset="" data-y="bottom" data-voffset="50"
                                     data-width="['auto']" data-height="['auto']" data-transform_idle="o:1;"
                                     data-transform_hover="o:1;rX:0;rY:0;rZ:0;z:0;s:300;e:Power1.easeInOut;"
                                     data-style_hover="c:rgba(255, 255, 255, 1.00);bg:rgba(41, 46, 49, 1.00);cursor:pointer;"
                                     data-transform_in="opacity:0;s:300;e:Power3.easeInOut;"
                                     data-transform_out="opacity:0;s:300;s:300;" data-start="0" data-splitin="none"
                                     data-splitout="none"
                                     data-actions='[{"event":"click","action":"startlayer","layer":"slide-331-layer-3","delay":""},{"event":"click","action":"startlayer","layer":"slide-331-layer-5","delay":"200"},{"event":"click","action":"stoplayer","layer":"slide-331-layer-1","delay":""}]'
                                     data-responsive_offset="on" data-responsive="off" data-lasttriggerstate="reset"
                                     style="z-index: 6; white-space: nowrap;outline:none;box-shadow:none;box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;">
                                    <i class="pe-7s-note2"
                                       style="font-size: 21px; float: left;margin-top:-6px;margin-right:10px;"></i> VIEW
                                    RECIPE
                                </div>

                                <!-- LAYER NR. 3 -->
                                <div class="tp-caption FoodCarousel-CloseButton rev-btn  tp-resizeme"
                                     id="slide-331-layer-5" data-x="441" data-y="110" data-width="['auto']"
                                     data-height="['auto']" data-transform_idle="o:1;"
                                     data-transform_hover="o:1;rX:0;rY:0;rZ:0;z:0;s:300;e:Power1.easeInOut;"
                                     data-style_hover="c:rgba(255, 255, 255, 1.00);bg:rgba(41, 46, 49, 1.00);cursor:pointer;"
                                     data-transform_in="z:0;rX:0;rY:0;rZ:0;sX:0.9;sY:0.9;skX:0;skY:0;opacity:0;s:800;e:Power3.easeInOut;"
                                     data-transform_out="auto:auto;s:500;" data-start="bytrigger" data-splitin="none"
                                     data-splitout="none"
                                     data-actions='[{"event":"click","action":"stoplayer","layer":"slide-331-layer-3","delay":""},{"event":"click","action":"stoplayer","layer":"slide-331-layer-5","delay":""},{"event":"click","action":"startlayer","layer":"slide-331-layer-1","delay":""}]'
                                     data-responsive_offset="on" data-end="bytrigger" data-lasttriggerstate="reset"
                                     style="z-index: 7; white-space: nowrap;outline:none;box-shadow:none;box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;">
                                    <i class="fa fa-remove"></i></div>

                            </li>

                        </ul>

                        <div class="tp-bannertimer tp-bottom" style="visibility: hidden !important;"></div>

                    </div>

                </div>
                <!--end rev_slider_108_1_wrapper-->

            </div>
            <!--end col-md-12-->

        </div>
        <!--end row-->

    </div>
    <!--end container-->

</section>
<!--end slideshow section -->

<!--begin footer -->
<div class="footer">

    <!--begin container -->
    <div class="container">

        <!--begin row -->
        <div class="row footer-top">

            <!--begin col-md-3 -->
            <div class="col-md-3 padding-bottom-50">

                <h4>ABOUT US</h4>

                <p>Quis autem velis et reprehender etims quiste voluptate velit esse quam nihil etsa illum sedit
                    consequatur quias.</p>

                <a href="about.html" class="btn btn-lg btn-yellow-x-small scrool">OUR STORY</a>

            </div>
            <!--end col-md-3 -->

            <!--begin col-md-3 -->
            <div class="col-md-3 padding-bottom-50">

                <h4>LATEST RECIPES</h4>

                <ul class="footer-list">

                    <li class="first"><a href="#" target="blank">Cheddar Cheese Cauliflower Tots</a></li>

                    <li><a href="#" target="blank">Garlic Chicken &amp; White Wine Sauce</a></li>

                    <li><a href="#" target="blank">Spinach Mozzarella Grilled Cheese</a></li>

                    <li><a href="#" target="blank">Mini Chicken Roasted Cups</a></li>

                </ul>

            </div>
            <!--end col-md-3 -->

            <!--begin col-md-3 -->
            <div class="col-md-3 padding-bottom-50">

                <h4>FEATURED PLATES</h4>

                <ul class="footer-gallery">

                    <li class="popup-gallery">
                        <a class="popup2" href="static/file/instagram1-large.jpg">
                            <img src="static/picture/instagram1.jpg" alt="instagram">
                        </a>
                    </li>

                    <li class="popup-gallery">
                        <a class="popup2" href="static/file/instagram6-large.jpg">
                            <img src="static/picture/instagram6.jpg" alt="instagram">
                        </a>
                    </li>

                    <li class="popup-gallery">
                        <a class="popup2" href="static/file/instagram2-large.jpg">
                            <img src="static/picture/instagram2.jpg" alt="instagram">
                        </a>
                    </li>

                    <li class="popup-gallery">
                        <a class="popup2" href="static/file/instagram4-large.jpg">
                            <img src="static/picture/instagram4.jpg" alt="instagram">
                        </a>
                    </li>

                    <li class="popup-gallery">
                        <a class="popup2" href="static/file/instagram5-large.jpg">
                            <img src="static/picture/instagram5.jpg" alt="instagram">
                        </a>
                    </li>

                    <li class="popup-gallery">
                        <a class="popup2" href="static/file/instagram3-large.jpg">
                            <img src="static/picture/instagram3.jpg" alt="instagram">
                        </a>
                    </li>

                </ul>

            </div>
            <!--end col-md-3 -->

            <!--begin col-md-3 -->
            <div class="col-md-3 padding-bottom-50">

                <h4>CONTACT DETAILS</h4>

                <p>Quis autem velis eti reprehender etimes quiste volupta velit esse quam nihil.</p>

                <p class="contact_info"><i class="fa fa-map-marker"></i> Oxford Street, London, UK, N1 1ED</p>

                <p class="contact_info"><i class="fa fa-phone"></i> +44 987 654 321 / +44 123 456 789</p>

                <p class="contact_info"><i class="fa fa-envelope-square"></i> <a href="mailto:contact@restaurant.com">contact@restaurant.com</a>
                </p>

            </div>
            <!--end col-md-3 -->

        </div>
        <!--end row -->

        <!--begin row -->
        <div class="row">

            <!--begin footer-bottom -->
            <div class="footer-bottom">

                <!--begin col-md-5 -->
                <div class="col-md-5">

                    <!--begin copyright -->
                    <div class="copyright ">
                        <p>Copyright &copy; 2022.Company name All rights reserved.<a target="_blank"
                                                                                     href="https://sc.chinaz.com/moban/">&#x7F51;&#x9875;&#x6A21;&#x677F;</a>
                        </p>
                    </div>
                    <!--end copyright -->

                </div>
                <!--end col-md-5 -->

                <!--begin col-md-2 -->
                <div class="col-md-2 text-center">

                    <a href="#hero-section" class="scrool top-scroll"><i class="fa fa-angle-double-up"></i></a>

                </div>
                <!--end col-md-2 -->

                <!--begin col-md-5 -->
                <div class="col-md-5">

                    <!--begin footer_social -->
                    <ul class="footer_social">
                        <li>
                            Follow Us:
                        </li>
                        <li>
                            <a href="#">
                                <i class="fa fa-twitter"></i>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <i class="fa fa-pinterest"></i>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <i class="fa fa-facebook"></i>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <i class="fa fa-instagram"></i>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <i class="fa fa-youtube"></i>
                            </a>
                        </li>
                    </ul>
                    <!--end footer_social -->

                </div>
                <!--end col-md-5 -->

            </div>
            <!--end footer-bottom -->

        </div>
        <!--end row -->

    </div>
    <!--end container -->

</div>
<!--end footer -->


<!-- Load JS here for greater good =============================-->
<script src="static/js/jquery-1.11.3.min.js"></script>
<script src="static/js/axios.min.js"></script>
<script src="static/js/bootstrap.min.js"></script>
<script src="static/js/bootstrap-select.js"></script>
<script src="static/js/bootstrap-switch.js"></script>
<script src="static/js/jquery.magnific-popup.min.js"></script>
<script src="static/js/jquery.nav.js"></script>
<script src="static/js/jquery.scrollTo-min.js"></script>
<script src="static/js/SmoothScroll.js"></script>
<script src="static/js/wow.js"></script>

<!-- RS5.0 Core JS Files -->
<script type="text/javascript" src="static/js/jquery.themepunch.tools.min.js"></script>
<script type="text/javascript" src="static/js/jquery.themepunch.revolution.min.js"></script>

<script type="text/javascript" src="static/js/revolution.extension.carousel.min.js"></script>
<script type="text/javascript" src="static/js/revolution.extension.navigation.min.js"></script>
<script type="text/javascript" src="static/js/revolution.extension.actions.min.js"></script>
<script type="text/javascript" src="static/js/revolution.extension.layeranimation.min.js"></script>

<!-- begin custom script-->
<script src="static/js/custom.js"></script>
<script src="static/js/plugins.js"></script>

</body>
</html>
