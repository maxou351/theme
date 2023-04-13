document.addEventListener("DOMContentLoaded", function (event) {

    function enableAccountForm() {
        var accountForm = new AccountForm();
        accountForm.handleCountrySelectEvent();
        accountForm.handleDateChange();
        accountForm.inputToUpperCase("#lastName");
    }

    function enableFormIfValidData() {

        var selectCountry = document.getElementById("birthcountry");
        if (selectCountry) {
            var selection = selectCountry.value;
            var result = selection.match(/[a-zA-Z0-9]{7}/gi);
            if (result !== null) {
                enableAccountForm();
            }
        } else {
            enableAccountForm();
        }
    }

    enableFormIfValidData();

});
