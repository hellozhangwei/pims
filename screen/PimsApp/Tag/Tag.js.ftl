
<script>
function findSystemAndProject(assetId) {
    $.ajax({
        type: "POST",
        url: "${sri.screenUrlInstance.url}/getSystem",
        data:{ assetId:assetId,moquiSessionToken: "${(ec.web.sessionToken)!}"},
        success: function(data) {
            $("#CreateTag_systemName").val(data.systemName);
            $("#CreateTag_workEffortName").val(data.workEffortName);
        },
        error: function(data) {
            console.log("======error===data=====" + data);
        }
    });
}

$("#CreateTag_parentAssetId").change(function(){
    findSystemAndProject($(this).val())
});
</script>