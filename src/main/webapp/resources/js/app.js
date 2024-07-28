document.addEventListener("DOMContentLoaded", function() {

  let messages = {};

  if (currentLocale === "pl") {
    messages = {
      selectCategory: "Proszę wybrać przynajmniej jedną kategorię.",
      enterQuantity: "Proszę podać liczbę worków.",
      quantityGreaterThanZero: "Liczba worków musi być większa od zera.",
      selectInstitution: "Proszę wybrać organizację.",
      enterStreet: "Proszę podać ulicę.",
      enterCity: "Proszę podać miasto.",
      enterZipCode: "Proszę podać kod pocztowy.",
      zipCodeFormat: "Proszę podać kod pocztowy w formacie 00-000.",
      enterPhoneNumber: "Proszę podać numer telefonu.",
      correctPhoneNumber: "Proszę podać poprawny numer telefonu (same cyfry, opcjonalnie z plusem).",
      enterDate: "Proszę podać datę.",
      dateNotEarlierThanToday: "Data odbioru nie może być wcześniejsza niż dzisiaj.",
      enterTime: "Proszę podać godzinę.",
      timeBetween: "Godzina odbioru musi być między 7:00 a 20:00."
    };
  } else if (currentLocale === "nl") {
    messages = {
      selectCategory: "Selecteer alstublieft ten minste één categorie.",
      enterQuantity: "Voer het aantal zakken in.",
      quantityGreaterThanZero: "Het aantal zakken moet groter zijn dan nul.",
      selectInstitution: "Selecteer een instelling.",
      enterStreet: "Voer de straat in.",
      enterCity: "Voer de stad in.",
      enterZipCode: "Voer de postcode in.",
      zipCodeFormat: "Voer de postcode in het formaat 00-000 in.",
      enterPhoneNumber: "Voer het telefoonnummer in.",
      correctPhoneNumber: "Voer een geldig telefoonnummer in (alleen cijfers, optioneel met een plus).",
      enterDate: "Voer de datum in.",
      dateNotEarlierThanToday: "De ophaaldatum mag niet eerder zijn dan vandaag.",
      enterTime: "Voer de tijd in.",
      timeBetween: "De ophaaltijd moet tussen 7:00 en 20:00 uur zijn."
    };
  } else if (currentLocale === "de") {
    messages = {
      selectCategory: "Bitte wählen Sie mindestens eine Kategorie aus.",
      enterQuantity: "Bitte geben Sie die Anzahl der Säcke ein.",
      quantityGreaterThanZero: "Die Anzahl der Säcke muss größer als null sein.",
      selectInstitution: "Bitte wählen Sie eine Institution aus.",
      enterStreet: "Bitte geben Sie die Straße ein.",
      enterCity: "Bitte geben Sie die Stadt ein.",
      enterZipCode: "Bitte geben Sie die Postleitzahl ein.",
      zipCodeFormat: "Bitte geben Sie die Postleitzahl im Format 00-000 ein.",
      enterPhoneNumber: "Bitte geben Sie die Telefonnummer ein.",
      correctPhoneNumber: "Bitte geben Sie eine gültige Telefonnummer ein (nur Zahlen, optional mit Plus).",
      enterDate: "Bitte geben Sie das Datum ein.",
      dateNotEarlierThanToday: "Das Abholdatum darf nicht vor heute liegen.",
      enterTime: "Bitte geben Sie die Zeit ein.",
      timeBetween: "Die Abholzeit muss zwischen 7:00 und 20:00 Uhr liegen."
    };
  } else if (currentLocale === "cs") {
    messages = {
      selectCategory: "Vyberte prosím alespoň jednu kategorii.",
      enterQuantity: "Zadejte počet pytlů.",
      quantityGreaterThanZero: "Počet pytlů musí být větší než nula.",
      selectInstitution: "Vyberte prosím instituci.",
      enterStreet: "Zadejte ulici.",
      enterCity: "Zadejte město.",
      enterZipCode: "Zadejte poštovní směrovací číslo.",
      zipCodeFormat: "Zadejte poštovní směrovací číslo ve formátu 00-000.",
      enterPhoneNumber: "Zadejte telefonní číslo.",
      correctPhoneNumber: "Zadejte platné telefonní číslo (pouze číslice, volitelně s plus).",
      enterDate: "Zadejte datum.",
      dateNotEarlierThanToday: "Datum vyzvednutí nemůže být dříve než dnes.",
      enterTime: "Zadejte čas.",
      timeBetween: "Čas vyzvednutí musí být mezi 7:00 a 20:00."
    };
  } else {
    messages = {
      selectCategory: "Please select at least one category.",
      enterQuantity: "Please enter the number of bags.",
      quantityGreaterThanZero: "The number of bags must be greater than zero.",
      selectInstitution: "Please select an institution.",
      enterStreet: "Please enter the street.",
      enterCity: "Please enter the city.",
      enterZipCode: "Please enter the postal code.",
      zipCodeFormat: "Please enter the postal code in the format 00-000.",
      enterPhoneNumber: "Please enter the phone number.",
      correctPhoneNumber: "Please enter a valid phone number (digits only, optionally with a plus).",
      enterDate: "Please enter the date.",
      dateNotEarlierThanToday: "The pickup date cannot be earlier than today.",
      enterTime: "Please enter the time.",
      timeBetween: "The pickup time must be between 7:00 and 20:00."
    };
  }

  class FormSelect {
    constructor($el) {
      this.$el = $el;
      this.options = [...$el.children];
      this.init();
    }

    init() {
      this.createElements();
      this.addEvents();
      this.$el.parentElement.removeChild(this.$el);
    }

    createElements() {
      this.valueInput = document.createElement("input");
      this.valueInput.type = "text";
      this.valueInput.name = this.$el.name;

      this.dropdown = document.createElement("div");
      this.dropdown.classList.add("dropdown");

      this.ul = document.createElement("ul");

      this.options.forEach((el, i) => {
        const li = document.createElement("li");
        li.dataset.value = el.value;
        li.innerText = el.innerText;

        if (i === 0) {
          this.current = document.createElement("div");
          this.current.innerText = el.innerText;
          this.dropdown.appendChild(this.current);
          this.valueInput.value = el.value;
          li.classList.add("selected");
        }

        this.ul.appendChild(li);
      });

      this.dropdown.appendChild(this.ul);
      this.dropdown.appendChild(this.valueInput);
      this.$el.parentElement.appendChild(this.dropdown);
    }

    addEvents() {
      this.dropdown.addEventListener("click", e => {
        const target = e.target;
        this.dropdown.classList.toggle("selecting");

        if (target.tagName === "LI") {
          this.valueInput.value = target.dataset.value;
          this.current.innerText = target.innerText;
        }
      });
    }
  }

  document.querySelectorAll(".form-group--dropdown select").forEach(el => {
    new FormSelect(el);
  });

  document.addEventListener("click", function(e) {
    const target = e.target;
    const tagName = target.tagName;
    if (target.classList.contains("dropdown")) return false;

    if (tagName === "LI" && target.parentElement.parentElement.classList.contains("dropdown")) {
      return false;
    }

    if (tagName === "DIV" && target.parentElement.classList.contains("dropdown")) {
      return false;
    }

    document.querySelectorAll(".form-group--dropdown .dropdown").forEach(el => {
      el.classList.remove("selecting");
    });
  });

  class FormSteps {
    constructor(form) {
      this.$form = form;
      this.$next = form.querySelectorAll(".next-step");
      this.$prev = form.querySelectorAll(".prev-step");
      this.$step = form.querySelector(".form--steps-counter span");
      this.currentStep = 1;

      this.$stepInstructions = form.querySelectorAll(".form--steps-instructions p");
      const $stepForms = form.querySelectorAll("form > div");
      this.slides = [...this.$stepInstructions, ...$stepForms];

      this.init();
    }

    init() {
      this.events();
      this.updateForm();
      document.addEventListener("keypress", (e) => {
        if (e.key === "Enter") {
          e.preventDefault();
          this.handleFormValidation();
        }
      });
    }

    events() {
      this.$next.forEach(btn => {
        btn.addEventListener("click", e => {
          e.preventDefault();
          this.handleFormValidation();
        });
      });

      this.$prev.forEach(btn => {
        btn.addEventListener("click", e => {
          e.preventDefault();
          this.currentStep--;
          this.updateForm();
        });
      });

      this.$form.querySelector("form").addEventListener("submit", e => this.submit(e));
    }

    handleFormValidation() {
      if (this.currentStep === 1 && this.validateForm1()) {
        this.currentStep++;
      } else if (this.currentStep === 2 && this.validateForm2()) {
        this.currentStep++;
      } else if (this.currentStep === 3 && this.validateForm3()) {
        this.currentStep++;
      } else if (this.currentStep === 4 && this.validateForm4()) {
        this.currentStep++;
      }
      this.updateForm();
    }

    updateForm() {
      this.$step.innerText = this.currentStep;

      this.slides.forEach(slide => {
        slide.classList.remove("active");
        if (slide.dataset.step == this.currentStep) {
          slide.classList.add("active");
        }
      });

      this.$stepInstructions[0].parentElement.parentElement.hidden = this.currentStep >= 5;
      this.$step.parentElement.hidden = this.currentStep >= 5;

      if (this.currentStep === 5) {
        this.updateSummary();
      }
    }

    validateForm1() {
      const categories = document.querySelectorAll('input[name="categories"]:checked');
      if (categories.length === 0) {
        alert(messages.selectCategory);
        return false;
      }
      return true;
    }

    validateForm2() {
      const quantity = document.querySelector('input[name="quantity"]').value;
      const quantityPattern = /[0-9]/;
      if (!quantityPattern.test(quantity)) {
        alert(messages.enterQuantity);
        return false;
      }
      if (quantity <= 0) {
        alert(messages.quantityGreaterThanZero);
        return false;
      }
      return true;
    }

    validateForm3() {
      const institution = document.querySelector('input[name="institution"]:checked');
      if (!institution) {
        alert(messages.selectInstitution);
        return false;
      }
      return true;
    }

    validateForm4() {
      let isValid = true;
      let stringBuilder = [];

      const street = document.querySelector('input[name="street"]').value;
      if (street.length === 0) {
        stringBuilder.push(messages.enterStreet);
      }

      const city = document.querySelector('input[name="city"]').value;
      if (city.length === 0) {
        stringBuilder.push(messages.enterCity);
      }

      const zipCode = document.querySelector('input[name="zipCode"]').value;
      const zipCodePattern = /^[0-9]{2}-[0-9]{3}$/;

      if (zipCode.length === 0) {
        stringBuilder.push(messages.enterZipCode);
      }

      if (zipCode.length !== 0 && !zipCodePattern.test(zipCode)) {
        stringBuilder.push(messages.zipCodeFormat);
        isValid = false;
      }

      const phone = document.querySelector('input[name="phone"]').value;
      const phonePattern = /^\+?[0-9]+$/;

      if (phone.length === 0) {
        stringBuilder.push(messages.enterPhoneNumber);
      }
      if (phone.length !== 0 && !phonePattern.test(phone)) {
        stringBuilder.push(messages.correctPhoneNumber);
        isValid = false;
      }

      const pickUpDate = document.querySelector('input[name="pickUpDate"]').value;
      const today = new Date().toISOString().split('T')[0];
      if (pickUpDate.length === 0) {
        stringBuilder.push(messages.enterDate);
      }
      if (pickUpDate.length !== 0 && pickUpDate < today) {
        stringBuilder.push(messages.dateNotEarlierThanToday);
        isValid = false;
      }

      const pickUpTime = document.querySelector('input[name="pickUpTime"]').value;
      if (pickUpTime.length === 0) {
        stringBuilder.push(messages.enterTime);
        isValid = false;
      }
      const [hours] = pickUpTime.split(':');
      if (pickUpTime.length !== 0 && (hours < 7 || hours > 20)) {
        stringBuilder.push(messages.timeBetween);
        isValid = false;
      }

      if (!isValid) {
        alert(stringBuilder.join("\n"));
      }

      return isValid;
    }

    updateSummary() {
      const quantity = document.querySelector('input[name="quantity"]').value;
      const categories = [...document.querySelectorAll('input[name="categories"]:checked')].map(input => input.parentElement.children[3].innerText.toLowerCase());
      const institution = document.querySelector('input[name="institution"]:checked').nextElementSibling.nextElementSibling.querySelector('.title').innerText;
      const street = document.querySelector('input[name="street"]').value;
      const city = document.querySelector('input[name="city"]').value;
      const zipCode = document.querySelector('input[name="zipCode"]').value;
      const phone = document.querySelector('input[name="phone"]').value;
      const pickUpDate = document.querySelector('input[name="pickUpDate"]').value;
      const pickUpTime = document.querySelector('input[name="pickUpTime"]').value;
      const pickUpComment = document.querySelector('textarea[name="pickUpComment"]').value;

      document.querySelector('.summary--quantity').innerText = quantity;
      document.querySelector('.summary--categories').innerText = "- " + categories.join('\n- ');
      document.querySelector('.summary--institution').innerText = institution;
      document.querySelector('.summary--street').innerText = street;
      document.querySelector('.summary--city').innerText = city;
      document.querySelector('.summary--zipcode').innerText = zipCode;
      document.querySelector('.summary--phone').innerText = phone;
      document.querySelector('.summary--pickUpDate').innerText = pickUpDate;
      document.querySelector('.summary--pickUpTime').innerText = pickUpTime;
      document.querySelector('.summary--pickUpComment').innerText = pickUpComment;
    }
  }

  const form = document.querySelector(".form--steps");
  if (form !== null) {
    new FormSteps(form);
  }
});
