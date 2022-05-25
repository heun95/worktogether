<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<link rel="stylesheet" href="/resources/gantt/dist/style.css" />
<link rel="stylesheet" href="/resources/gantt/reset.css" />
<link href="/resources/css/project.css" rel="stylesheet" type="text/css" />
<style>

h2 {
  font-size: 29px;
}
.info{
	color : #4f9dff;
}
.success{
	color : #6fbe36;
}
.dark{
	color : #271050;
}
.danger{
	color : #ff5d5d;
}
</style>
<div class="row">
	<div class="col-lg-12">
		<div class="card">
			<div class="card-body">
			
				<%@ include file="includeTab.jsp" %>
				<div>
					<span class="info">●</span>요청 &nbsp;
					<span class="success">●</span>진행 &nbsp;
					<span class="dark">●</span>완료  &nbsp;
					<span class="danger">●</span>이슈 &nbsp;
				</div>	
				<br>
				
			    <div id="gstc"></div>
		    
    		</div>
    	</div>
    </div>
</div>
    
<%@ include file="modal.jsp"%>
    
    <script src="/resources/gantt/dist/gstc.wasm.umd.min.js"></script>
    <script src="/resources/gantt/dist/plugins/timeline-pointer.umd.min.js"></script>
    <script src="/resources/gantt/dist/plugins/selection.umd.min.js"></script>
    <script src="/resources/gantt/dist/plugins/item-movement.umd.min.js"></script>
    <script src="/resources/gantt/dist/plugins/item-resizing.umd.min.js"></script>
    <script src="/resources/gantt/dist/plugins/calendar-scroll.umd.min.js"></script>
    <script src="/resources/gantt/dist/plugins/highlight-weekends.umd.min.js"></script>
    <script src="/resources/gantt/dist/plugins/progress-bar.umd.min.js"></script>
    <script src="/resources/gantt/dist/plugins/time-bookmarks.umd.min.js"></script>
    <script src="/resources/gantt/dist/plugins/dependency-lines.umd.min.js"></script>
    <script src="/resources/gantt/dist/plugins/export-image.umd.min.js"></script>
    <script src="/resources/gantt/dist/plugins/export-pdf.umd.min.js"></script>
    <script src="/resources/gantt/dist/plugins/item-resizing.umd.min.js"></script>
	
	<script src="/resources/js/project.js"></script>
    <!-- replace this path  -->
    <script>
    	function getColor(p_state){
    		var color = '';
    			
    		if(p_state == "요청"){
    			color = '#4f9dff';
    		}else if(p_state == "진행"){
    			color = '#6fbe36';
    		}else if(p_state == "완료"){
    			color = '#271050';
    		}else if(p_state == "이슈"){
    			color = '#ff5d5d';
    		}
    		
    		return color;
    	}
    
		var rowsFromDB = [];
		var itemsFromDB = [];
		
		$.ajax({
		  url: "/project/ganttdata",
		  method: "GET",
		  data : {
			  'projId': "${sessionScope.projId }"
		  },
		  async: false,
		  success: function (res) {
			
		  	console.log("res : ", res);
		       
		  	$.each(res, function(i, v) {
		   	 	var workMngr = '';
		   	 	$.each(v.workMngr, function(i, vv) {
		   	 		workMngr += vv.workMngrNm;
		   	 		if(i < v.workMngr.length-1){
			   	 		console.log(i, v.workMngr.length-1)
			   	 		workMngr += ', ';
		   	 		}
		   	 	})
		    	var rowtemp = {
		   			id : v.workId, 
		   			label : v.workTitle,
		   			mngr : workMngr,
		   			progress : v.workProgress
		    	};
// 		    	rowtemp.id = v.workId;
// 		    	rowtemp.label = v.workTitle;
		    	
		    	var workStrtDt = toStringYmd(new Date(v.workStrtDt));
		    	
		    	var endDate = new Date(v.workEndDt);
		    	endDate.setDate(endDate.getDate()+1);
		    	
		    	var workEndDt = toStringYmd(endDate);
		    	
		    	var itemtemp = {
		    		id: i,
		            label: v.workTitle,
					rowId: v.workId,
					style: { background: getColor(v.workState)},
	                time: {
		                start: GSTC.api.date(workStrtDt).startOf('day').valueOf(),
		                end: GSTC.api.date(workEndDt).endOf('day').valueOf(),
	              	}
		    	};
		    	
		    	
		    	rowsFromDB.push(rowtemp);
		    	itemsFromDB.push(itemtemp);
		    	
		  	})
// 	    	console.log("rowsFromDB : ", rowsFromDB);
// 	    	console.log("itemsFromDB : ", itemsFromDB);
			
		  },
		  dataType: "json"
		});
		
      const columnsFromDB = [
//         {
//           id: 'id',
//           label: 'ID',
//           data: ({ row }) => GSTC.api.sourceID(row.id), // show original id (not internal GSTCID)
//           sortable: ({ row }) => Number(GSTC.api.sourceID(row.id)), // sort by id converted to number
//           width: 80,
//           header: {
//             content: 'ID',
//           },
//         },
        {
          id: 'label',
          data: 'label',
          sortable: 'label',
          isHTML: false,
          width: 150,
          header: {
            content: '업무제목',
          },
        },
        {
          id: 'mngr',
          data: 'mngr',
          sortable: 'mngr',
          isHTML: false,
          width: 150,
          header: {
            content: '담당자',
          },
        },
        {
          id: 'progress',
          data: 'progress',
          sortable: 'progress',
          isHTML: false,
          width: 70,
          header: {
            content: '진행도',
          },
        },
      ];

      // Configuration object
      const config = {
        // for free key for your domain please visit https://gstc.neuronet.io/free-key
        // if you need commercial license please visit https://gantt-schedule-timeline-calendar.neuronet.io/pricing

        licenseKey:
          '====BEGIN LICENSE KEY====\nImiajcI9wAehsAXUnGXDJSk+YWnT7vq2Qydib6v9mwB69KSlEyma3Ugn5jZzd8OBmGe3Y1USqOfkzlY57d/LZIwR5D8idUqGqNPUPZdvyBOV4HGYcewsgYGgdWV02f47lQ7j6RDlYBYAx9jtz1YGcbyZLwIKWslW8KHXseayiiy3aW9S7N5NujM3akISSDWh+zGQSb6mzuFmDu5h1cgMb9Q/ZI4Dhbi1sIX9v6ilvfUHuUkgXtxeV9t4cBPVaGgL40la91RM9Lah3jnwcpNA3XF1iTpfoU9sLzGQ9TMQpVTGZaTCqBYHGTL2C7g0/6K33VOfuhFn4dkqQnff760LDg==||U2FsdGVkX1+T6NDsw05MYHeu+STwMb/cBnKCwFEdMAlaH+/pieYKZHROna7SSfyE4HIq5MEEji/hJO3YUJgCwPnCIafAJm8ZegjeQfOxQgk=\nX3nCAVKTbvnTMzQ10rau9pKiIrwrfBtJgNPGAby7U4BgsECOTSs/3jHBl+EKsBC5cS+bxVE8ZxBHLBTOzDqMqUGOTwtWaQD3rwcaMwfNKh0ag2/x6ah0nB+KarlUmpa2AXhOCkouTJgmJDeGt0HwYsfl9Ja80ThHCTruh/cXu65FcCJW5EmNg/alpYVOzvA8gyyRub8CtdIZ7sQ7S6AgMAeMKve0RP8H/dp5cTBOGWiS24oXpOXLqtJjcKdKEI0qWO4/0O9ydmdW4rWCOLa3K78Dp69QSm3LbmoR2IITncd8v5A1UBvTsrUNltdv2LAto19DsBsQkO9/TDID3BllxQ==\n====END LICENSE KEY====',
        plugins: [
          TimelinePointer.Plugin(), // timeline pointer must go first before selection, resizing and movement
          Selection.Plugin(),
          ItemResizing.Plugin(), // resizing must fo before movement
          ItemMovement.Plugin(),
        ],
        list: {
          columns: {
            data: GSTC.api.fromArray(columnsFromDB),
          },
          rows: GSTC.api.fromArray(rowsFromDB),
        },
        chart: {
          items: GSTC.api.fromArray(itemsFromDB),
        },
        innerHeight : 450
      };

      // Generate GSTC state from configuration object
      const state = GSTC.api.stateFromConfig(config);
      globalThis.state = state;

      // Mount the component
      const app = GSTC({
        element: document.getElementById('gstc'),
        state,
      });

      globalThis.gstc = app;
      
      $(function(){
    	  $(document).on("click", ".gstc__chart-timeline-items-row-item", function(){
    		  console.log("click");
    		  var gstcid = $(this).parents(".gstc__chart-timeline-items-row").data("gstcid");
    		  console.log(gstcid);
    		  
    		  var workId = gstcid.substr(gstcid.indexOf("-")+1);
    		  console.log(workId);
    		  
              var myOffcanvas = $("#wokrDetail")
				var bsOffcanvas = new bootstrap.Offcanvas(myOffcanvas)
              bsOffcanvas.show();
              // 디테일
          	  workDetail(workId);
              // 댓글리스트  
              rplList(workId);
    		  
    	  })
      })
    </script>
