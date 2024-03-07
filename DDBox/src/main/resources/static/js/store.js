
// Tab Index
/*var prdtClCd = '';

$(function(){*/
    /*스토어 메인 상품정보 조회*/
/*    fn_storeMainSerach();
});*/

/*스토어 메인 상품정보 조회*/
/*function fn_storeMainSerach(){
    var paramData = {'prdtClCd' : prdtClCd};

    if (prdtClCd == null || prdtClCd == '')
    {
        $.ajax({
            url: "/on/oh/ohd/StoreMain/selectStoreMainList.do",
            type: "POST",
            contentType: "application/json;charset=UTF-8",
            data: JSON.stringify(paramData),
            success: function (data, textStatus, jqXHR) {
                $("#storeMainList").empty();
                $("#storeMainList").append(data);
            },
            error: function(xhr,status,error){
                 var err = JSON.parse(xhr.responseText);
                 alert(xhr.status);
                 alert(err.message);
            }
        });
    }
    else
    {
        $.ajax({
            url: "/on/oh/ohd/StoreMain/selectStoreCateList.do",
            type: "POST",
            contentType: "application/json;charset=UTF-8",
            data: JSON.stringify(paramData),
            success: function (data, textStatus, jqXHR) {
                $("#storeMainList").empty();
                $("#storeMainList").append(data);
            },
            error: function(xhr,status,error){
                 var err = JSON.parse(xhr.responseText);
                 alert(xhr.status);
                 alert(err.message);
            }
        });
    }

}*/

//상세페이지 이동
/*function fn_storeDetail(prdtNo){

	var contentUrl = "/store/detail?prdtClCd="+prdtClCd+"&prdtNo="+prdtNo;

    //$("#storeForm").append("<input type='hidden' name='cmbndKindNo' value='" + cmbndKindNo + "' />");
    $("#storeForm").append("<input type='hidden' name='postAt' value='Y' />");
    //$("#storeForm").attr("action",contentUrl+"?cmbndKindNo="+cmbndKindNo);
    $("#storeForm").attr("action",contentUrl);
    //$("#storeForm").submit();
	//넷퍼넬 적용
    $("#storeForm").submit();
}*/


/* 스토어 타이틀 */
/*function fn_chgStoreTab(cdId){

	$(".tab-list ul li").attr('class','');

    if (storeTabCdId != null && storeTabCdId != "") {
        $('#divCategoryPrdtArea_'+storeTabCdId).hide();
    }
    storeTabCdId = cdId;

    switch(cdId){
    case ''        :
    case undefined :
        $('#divNewPrdtArea').show();
        $('#storeTab_').attr('class','on');
        break;
    default        :
        $('#divNewPrdtArea').hide();
        $('#divCategoryPrdtArea_'+cdId).show();
        $('#storeTab_'+cdId).attr('class','on');
    }
}*/

$(document).on('click', '.box-pulldown .tit .btn-toggle', function(){
        $(this).closest('.box-pulldown').toggleClass('on');

        if( $(this).closest('.box-pulldown').hasClass('on') ){
            $(this).find('.ico-arr-toggle-down').innerHTML('<span class="material-symbols-outlined">expand_less</span>');
        }
        else {
            $(this).find('.ico-arr-toggle-down').innerHTML('<span class="material-symbols-outlined">expand_more</span>');
        }
    });
