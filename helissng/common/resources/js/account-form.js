function AccountForm() {
	this.CODE_INSEE_FRANCE = "99100FR";
	// before 1943 we don't have any city referential.
	this.MAX_YEAR_ENABLE = 1943;

	var BASE = "/auth/realms/heliss_ng/";
	var PROVIDER_ID = "referentiel.resource_provider";
	this.API_BIRTH_PLACE = BASE + PROVIDER_ID + "/api/v1/birthplace";

	this.birthDateInput = document.getElementById("birthdate");
	this.selectCountry = document.getElementById("birthcountry");
	this.formGroupBirthplace = document.getElementById("birthPlaceGroup");
	this.birthPlaceInput = document.getElementById("birthplace");
	this.submitAccountButton = document.getElementById("updateAccount");

	this.citiesBind = this.getCities.bind(this);
	this.shouldDisplayCities();

	this.fallbackDatePicker = document.getElementById("fallbackDatePicker");
	this.nativeDatePicker = document.getElementById("nativeDatePicker");
	this.nativeDatePickerLabel = document.getElementById("nativeDatePickerLabel");

	// Fallback control
	this.yearSelect = document.getElementById("year");
	this.monthSelect = document.getElementById("month");
	this.daySelect = document.getElementById("day");

	this.previousDay;
	this.isFallbackDate = false;

	// Mask fallback by default
	if (this.fallbackDatePicker) {
		this.fallbackDatePicker.style.display = "none";   
        this.init();
	}

}

/**
 * Initialize the form control by checking : 
 * if the browser support date input 
 */
AccountForm.prototype.init = function () {
	if (!this.checkDateInput()) {
		this.nativeDatePickerLabel.style.display = 'none';
		this.nativeDatePicker.style.marginBottom = '0px';
		this.birthDateInput.type = 'hidden';
		this.fallbackDatePicker.style.display = "block";
		this.isFallbackDate = true;

		this.populateDays(this.monthSelect.value);
		this.populateYears();

		this.yearSelect.addEventListener("change", function () {
			this.populateDays(this.monthSelect.value);
			this.handleDateChange();
		}.bind(this));

		this.monthSelect.addEventListener("change", function () {
			this.populateDays(this.monthSelect.value);
			this.handleDateChange();
		}.bind(this));


		this.daySelect.addEventListener("change", function () {
			this.previousDay = this.daySelect.value;
			this.handleDateChange();
		}.bind(this));
	}
};

AccountForm.prototype.populateDays = function (month) {

	// if used in case of update. save the current value.
	var currentDay = this.daySelect.value;

	// delete previousely added days to re-add it correctly
	while (this.daySelect.firstChild) {
		this.daySelect.removeChild(this.daySelect.firstChild);
	}

	// Variable that contains the number of days to display
	var dayNum;

	// 31 or 30 days?
	if (month === '01' || month === '03' || month === '05' || month === '07' || month === '08' || month === '10' || month === '12') {
		dayNum = 31;
	} else if (month === '04' || month === '06' || month === '09' || month === '11') {
		dayNum = 30;
	} else {
		// If month is "Février", we compute if this is a bissextile year
		var year = this.yearSelect.value;
		var leap = new Date(year, 1, 29).getMonth() === 1;
		dayNum = leap ? 29 : 28;
	}

	var optionToSelect = 0;
	// Add day to the select
	for (var i = 1; i <= dayNum; i++) {
		var option = document.createElement('option');
		// Handle the first 9 days as 0x base.
		if (i < 10) {
			option.textContent = '0' + i;
		} else {
			option.textContent = i;
		}
		option.value = option.textContent;
		// detect which item was previously selected
		if (currentDay && (Number(currentDay) === Number(i) || currentDay === '0' + i)) {
			optionToSelect = i;
		}
		this.daySelect.appendChild(option);
	}
	// Set selection to the previously selected item
        if (optionToSelect > 0) {
            optionToSelect--;
        }
	this.daySelect.options[optionToSelect].selected = true;

	// test if the day was already set, to avoid the re-initialization of the day select
	if (this.previousDay) {
		this.daySelect.value = this.previousDay;

		if (this.daySelect.value === "") {
			this.daySelect.value = this.previousDay - 1;
		}

		if (this.daySelect.value === "") {
			this.daySelect.value = this.previousDay - 2;
		}

		if (this.daySelect.value === "") {
			this.daySelect.value = this.previousDay - 3;
		}
	}
};

AccountForm.prototype.populateYears = function () {

	// if used in case of update. save the current value.
	var currentYear = this.yearSelect.value;

	// delete previousely added days to re-add it correctly
	while (this.yearSelect.firstChild) {
		this.yearSelect.removeChild(this.yearSelect.firstChild);
	}

	// Retrieve the current year
	var date = new Date();
	var year = date.getFullYear();

	// Display the current year and the previous 100 years for the select element.
	for (var i = 0; i <= 100; i++) {
		var option = document.createElement('option');
		option.textContent = year - i;
		option.value = year - i;
		if (currentYear && Number(currentYear) === (Number(year) - i)) {
			option.selected = true;
		}
		this.yearSelect.appendChild(option);
	}
};

/**
 * Wait for a certain delay when passed to a function.
 * @param {Function} func 
 * @param {Number} wait 
 * @param {Boolean} immediate 
 */
AccountForm.prototype.debounced = function (func, wait, immediate) {
	var timeout;
	return function () {
		var context = this, args = arguments;
		var callNow = immediate && !timeout;
		clearTimeout(timeout);
		timeout = setTimeout(function () {
			timeout = null;
			if (!immediate) {
				func.apply(this, args);
			}
		}, wait);
		if (callNow) func.apply(context, args);
	};
};


AccountForm.prototype.handleCountrySelectEvent = function () {
	if (this.selectCountry) {
		this.selectCountry.addEventListener("change", function (event) {
			this.shouldDisplayCities();
		}.bind(this));
	}
};

/**
 * handle any date change. Regardless of native or fallback
 * if in fallback, set the date to the native input date field 
 */
AccountForm.prototype.handleDateChange = function () {
	if (!this.isFallbackDate) {
		if (this.birthDateInput) {
			this.birthDateInput.addEventListener("focusout", function (event) {
				event.stopPropagation();
				this.shouldDisplayCities();
				this.changeDateValue();
			}.bind(this));
		}
	} else {
		var date = this.yearSelect.value + "-" + this.monthSelect.value + "-" + this.daySelect.value;
		this.birthDateInput.value = date;
		this.shouldDisplayCities();
	}
};

/**
 * Check the country input field and display the city input in case the insee code is france
 */
AccountForm.prototype.shouldDisplayCities = function () {
	if (this.selectCountry && this.birthDateInput) {
		var selection = this.selectCountry.value;
        var birthDateYear;
        if (!this.isFallbackDate) {
            var selectionDate = this.birthDateInput.value;
            /**
             * Trick to get year. As some browser convert date to YYYY-MM-DD and other to DD-MM-YYYY
             */
            var splitDate = selectionDate.split("-");
            var isEnglishDate = splitDate[0].length === 4 ? true : false;
            birthDateYear = isEnglishDate ? splitDate[0] : splitDate[2];
        } else {
            birthDateYear = this.yearSelect.value;
        }

        if (selection === this.CODE_INSEE_FRANCE && Number(birthDateYear) > this.MAX_YEAR_ENABLE) {
            this.formGroupBirthplace.style.display = "block";
            if (this.birthPlaceInput) {
                this.awesomplete = new Awesomplete(this.birthPlaceInput, {
                    filter: function (text, input) {
                        return true;
                    },
                    sort: function () {
                        return false;
                    }
                });
                this.bindCityes();
                this.birthPlaceInput.disabled = false;
                this.birthPlaceInput.type = "text";
                this.birthPlaceInput.required = "required";
            }
        } else {
            this.birthPlaceInput.type = "hidden";
            this.birthPlaceInput.value = "";
            this.birthPlaceInput.required = false;
            this.formGroupBirthplace.style.display = "none";
            this.unbindCityes();
            if (this.awesomplete) {
                this.awesomplete.list = [];
            }
        } 
	}
};

/**
 * Change html date value when html dom focus out
 */
AccountForm.prototype.changeDateValue = function () {
	if (this.birthDateInput) {
		var selectionDate = this.birthDateInput.value;
		/**
		 * Trick to get year. As some browser convert date to YYYY-MM-DD and other to DD-MM-YYYY
		 */
		document.getElementById("birthdate").value = selectionDate;
		document.getElementById("birthdate").defaultValue = selectionDate;
	}
};

/**
 * Add the keyup event binding to the birthPlace input
 */
AccountForm.prototype.bindCityes = function () {
	this.birthPlaceInput.addEventListener("keyup", this.debounced(this.citiesBind, 250));
};

/**
 * Add the keyup event binding from the birthPlace input
 */
AccountForm.prototype.unbindCityes = function () {
	this.birthPlaceInput.removeEventListener("keyup", this.citiesBind);
};

AccountForm.prototype.getCities = function (event) {
	if (event.key !== "ArrowUp" && event.key !== "ArrowDown") { //filter key that are used to navigate the response list
		var birthPlace = this.birthPlaceInput.value;
		var req = new XMLHttpRequest();
		var that = this;
		req.onreadystatechange = function (event) {
			if (this.readyState === XMLHttpRequest.DONE) {
				if (this.status === 200) {
					var cities = JSON.parse(this.responseText);
					that.awesomplete.list = cities.map(function (city) { return city.postalCode + " - " + city.townName; });
				}
			}
		};
		req.open('GET', this.API_BIRTH_PLACE + "?city=" + birthPlace, true);
		req.send(null);
	}

};

/**
 * Test if the browser support the input type Date
 */
AccountForm.prototype.checkDateInput = function () {
	var input = document.createElement('input');
	try {
		input.type = 'date';

		if (input.type === 'text') {
			return false;
		} else {
			var notADateValue = 'not-a-date';
			input.value = notADateValue;

			return (input.value !== notADateValue);

		}
	} catch (error) {
		return false;
	}

};

AccountForm.prototype.inputToUpperCase = function(inputSelector) {
	var input = document.querySelector(inputSelector)
	input.addEventListener("input", function(event) {
		var input = event.target;
		var start = input.selectionStart;
		var end = input.selectionEnd;
		input.value = input.value.toLocaleUpperCase();
		input.setSelectionRange(start, end);
	})
}