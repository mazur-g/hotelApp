/*odpowiada za wyswietlanie inputu dla formularza rezerwowania pokoju
 *gdy pokoj jedno osobowy to nie ma dwuosobowych lozek
 */
function controlBeds()
{
     var room_number = $('input[name="room_nr"]').val();
    if ($('#pokoj').val() == 1) 
    {
    $('.ilosc_lozek').hide();
    }
    if  (room_number < 400)
    {
    $('.ilosc_lozek2').show();
    }   
    if  (room_number > 400)
    {
    $('.ilosc_lozek2').hide();

    }
    if ($('#pokoj').val() > 1)
    {
    $('.ilosc_lozek').show();
    }
}
/* wyswietla formularz dodania konsjerza */
function showAddConcierge()
{
 $('#mostPickedRooms').hide();
 $('#mostPayfulRooms').hide();
 $('#availableRooms').hide();
 $('#addRoomDiv').hide();
 $('#addConciergeDiv').show();
 $('#addRoomResult').html("");
}

/* generuje zadanie do serwera zaplacenia rachunku */
function payBills(id_wynajecia)
{
    $.get($SCRIPT_ROOT + '/_requests',{req : 'payBills',
        id_wy : id_wynajecia});
   
    $.get($SCRIPT_ROOT + '/_requests',{
req: 'showBills'},
function(data)
{
    $('#billsDiv').html(data);
});

}
/* wyswietla formularz do dodania pokoju */
function showAddRoom()
{
 $('#mostPickedRooms').hide();
 $('#mostPayfulRooms').hide();
 $('#availableRooms').hide();
 $('#addRoomDiv').show();
 $('#addConciergeDiv').hide();
 $('#addRoomResult').html("");
 $('#addConciergeResult').html("");
}

/* generuje zadanie dodania konsjerza */
function addConcierge()
{
  $.get($SCRIPT_ROOT + '/_requests',
         {
             req: 'addConcierge',
             fname: $('input[name="fnameC"]').val(),
             lname: $('input[name="lnameC"]').val(),
             phone: $('input[name="phoneC"]').val(),
         },
         function(data)
         {  
             $('#myForm3')[0].reset();
             $('#addConciergeResult').html(data);
         });   
}
/*generuje zadanie dodania pokoju */
function addRoom()
{

                    $.get($SCRIPT_ROOT + '/_requests', {
                                req: 'addRoom',
                                amount_of_people: $('select#newRoomSpace').val(),
                                amount_of_bed: $('input[name="a_o_b"]').val(),
                                tv: $('input[name="newTv"]').is(':checked'),
                                bath: $('input[name="newBath"]').is(':checked'),
                                shower: $('input[name="newShower"]').is(':checked'),
                                bar: $('input[name="newBar"]').is(':checked'),
                                balcony: $('input[name="newBalcony"]').is(':checked'),    
                                          },function(data) {
                                                      $("#addRoomResult").html(data);
                                                      $('#myForm4')[0].reset();
                                                            });
                             }
 

/* generuje zadanie pokazania zarezerwowanych pokojow przez klienta i wyswietla je */ 
function showReservedRooms(){ 
                           $('#billsDiv').hide();
                           $('#addRoomDiv').hide();
                           $('#addConciergeDiv').hide();
                           $('#availableRooms').hide();
                           $('#reservedRoomsDiv').show();
                           $('#reserveRoom').hide();
                           $('#reserveRoomWithNumber').hide();
                           $.get($SCRIPT_ROOT + '/_requests',{req : 'showReservedRooms'},function(data)
                                   {
                                    $("#reservedRoomsDiv").html(data);   
                                   });
                             }

/* generuje zadanie pokazania najbardziej oplacalnych rachunkow i wyswietla odpowiedz*/
function showMostPayfulRooms()
{
    $('#addRoomDiv').hide();
    $('#addConciergeDiv').hide();
    $('#mostPickedRooms').hide();
    $('#mostPayfulRooms').show();
    $('#availableRooms').hide();
    $('#addRoomResult').html("");
    $('#addConciergeResult').html("");
    $.get($SCRIPT_ROOT + '/_requests',
            {req: 'showMostPayfulRooms'},
            function(data)
            {
                $('#mostPayfulRooms').html(data);
            }
            
         );
}
/* generuje zadanie pokazania najczesciej rezerwowanych pokojow i wyswietla je */
function showMostPickedRooms()
{
    $('#addRoomResult').html("");
    $('#addConciergeResult').html("");
    $('#addRoomDiv').hide();
    $('#addConciergeDiv').hide();
    $('#mostPickedRooms').show();
    $('#mostPayfulRooms').hide();
    $('#availableRooms').hide();
    $.get($SCRIPT_ROOT + '/_requests',
            {req: 'showMostPickedRooms'},
            function(data)
            {
                $('#mostPickedRooms').html(data);
            }
            
         );
}



/* wysyla zadanie pokazania dostepnych pokoj i wyswietla odpowiedz */ 
function showAvailableRooms()
{
    $('#billsDiv').hide();
    $('#addRoomResult').html("");
    $('#addConciergeResult').html("");
    $('#addRoomDiv').hide();
    $('#addConciergeDiv').hide();
    $('#result').html("");
     $('#mostPickedRooms').hide();
     $('#mostPayfulRooms').hide();
     $('#availableRooms').show();
     $('#reserveRoom').hide();
     $('#reserveRoomWithNumber').show();
     $('#availableRooms').show();
     $('#reservedRoomsDiv').hide();
     $.get($SCRIPT_ROOT + '/_requests',{req : 'showAvailableRooms'},function(data)
             {
                 $('#availableRooms').html(data);
             }); 
}

/* wysyla zadanie pokazania rachunkow i wyswietla odpowiedz */
function showBills()
{
    $('#billsDiv').show();
    $('#reserveRoomWithNumber').hide();
    $('#reserveRoom').hide();
    $('#availableRooms').hide();
    $('#reservedRoomsDiv').hide();
    $.get($SCRIPT_ROOT + '/_requests',{
        req: 'showBills'},
        function(data)
        {
            $('#billsDiv').html(data);
        });
}

/* wysyla zadanie zarezerwowania pokoju z danym numerem i wyswietla komunikat o powodzeniu/niepowodzeniu */
function reserveRoomWithNumber()
{
    $.get($SCRIPT_ROOT +  '/_requests',{
        req: 'reserveRoomWithNumber',
        roomNumber:  $('input[name="room_nr"]').val(),
        date_from: $('input[name="d_f"]').val(),
        date_to: $('input[name="d_t"]').val(),
        limousine: $('input[name="limousineN"]').val(),
        taxi : $('input[name="taxiN"]').val(),
        breakfast : $('input[name="breakfastN"]').val(),
        cleaning : $('input[name="cleaningN"]').val(),
        amount_of_bed: $('input[name="ilosc_podw"]').val()},function(data)
            {
                $('#result').html(data);
                $('#myForm2')[0].reset();
            });
}
/* wyswietla formularz rezerwowania pokoju */
function showRoomForm()
{
    $('#reservedRoomsDiv').hide();
    $('#billsDiv').hide();
    $('#reserveRoomWithNumber').hide();
    $('#reserveRoom').show();
    $('#availableRooms').hide();
}
/* generuje wyglad po 1 zaladowaniu strony (same przyciski bez formularzy) */
function init()
{
    $('#billsDiv').hide();
    $('#addRoomDiv').hide();
    $('#addConciergeDiv').hide();
    $('#availableRooms').hide();
    $('#reserveRoom').hide();
    $('#reserveRoomWithNumber').hide();
    controlBeds();
}


/* wysyla zadanie zarezerwowanie pokoju za pomoca formularza i wyswietla komunikat o powodzeniu/niepowodzeniu */
function reserveRoomForm() {
                    $('#result2').html("");
                    $.get($SCRIPT_ROOT + '/_requests', {
                                req: 'reserveRoomForm',
                                amount_of_people: $('select#pokoj').val(),
                                amount_of_bed: $('input[name="a_o_b"]').val(),
                                date_from: $('input[name="date_from"]').val(),
                                date_to: $('input[name="date_to"]').val(),
                                tv: $('input[name="tv"]').is(':checked'),
                                bath: $('input[name="bath"]').is(':checked'),
                                shower: $('input[name="shower"]').is(':checked'),
                                bar: $('input[name="bar"]').is(':checked'),
                                balcony: $('input[name="balcony"]').is(':checked'),    
                                limousine: $('input[name="limousine"]').is(':checked'),
                                taxi: $('input[name="taxi"]').is(':checked'),
                                breakfast: $('input[name="breakfast"]').is(':checked'),
                                cleaning: $('input[name="cleaning"]').is(':checked')
                                          },function(data) {
                                                      $("#result2").html(data);
                                                      $('#myForm')[0].reset();
                                                            });
                             }
         


