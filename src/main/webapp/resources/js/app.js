document.addEventListener("DOMContentLoaded", function() {

  /**
   * Form Select
   */
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
      // Input for value
      this.valueInput = document.createElement("input");
      this.valueInput.type = "text";
      this.valueInput.name = this.$el.name;

      // Dropdown container
      this.dropdown = document.createElement("div");
      this.dropdown.classList.add("dropdown");

      // List container
      this.ul = document.createElement("ul");

      // All list options
      this.options.forEach((el, i) => {
        const li = document.createElement("li");
        li.dataset.value = el.value;
        li.innerText = el.innerText;

        if (i === 0) {
          // First clickable option
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

        // Save new value only when clicked on li
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

  /**
   * Hide elements when clicked on document

   */



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

  /**
   * Switching between form steps
   */
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

    /**
     * Init all methods
     */
    init() {
      this.events();
      this.updateForm();
      document.addEventListener("keypress", (e) => {
        if (e.key === "Enter") {
          e.preventDefault();
          if (this.currentStep === 1 && this.validateForm1()) {
            this.currentStep++;
            this.updateForm();
          } else if (this.currentStep === 2 && this.validateForm2()) {
            this.currentStep++;
            this.updateForm();
          } else if (this.currentStep === 3 && this.validateForm3()) {
            this.currentStep++;
            this.updateForm();
          } else if (this.currentStep === 4 && this.validateForm4()) {
            this.currentStep++;
            this.updateForm();
          }
        }
      });
    }

    /**
     * All events that are happening in form
     */
    events() {
      // Next step
      this.$next.forEach(btn => {
        btn.addEventListener("click", e => {
          e.preventDefault();
          if (this.currentStep === 1) {
            if (this.validateForm1()) {
              this.currentStep++;
              this.updateForm();
            }
          } else if (this.currentStep === 2) {
            if (this.validateForm2()) {
              this.currentStep++;
              this.updateForm();
            }
          } else if (this.currentStep === 3) {
            if (this.validateForm3()) {
              this.currentStep++;
              this.updateForm();
            }
          } else if (this.currentStep === 4) {
            if (this.validateForm4()) {
              this.currentStep++;
              this.updateForm();
            }
          }
        });
      });

      // Previous step
      this.$prev.forEach(btn => {
        btn.addEventListener("click", e => {
          e.preventDefault();
          this.currentStep--;
          this.updateForm();
        });
      });

      // Form submit
      this.$form.querySelector("form").addEventListener("submit", e => this.submit(e));
    }

    /**
     * Update form front-end
     * Show next or previous section etc.
     */
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
        this.updateSummary()
      }
    }



    validateForm1() {
      const categories = document.querySelectorAll('input[name="categories"]:checked');
      if (categories.length === 0) {
        alert("Proszę wybrać przynajmniej jedną kategorię.");
        return false;
      }
      return true;
    }


    validateForm2() {
      const quantity = document.querySelector('input[name="quantity"]').value;
      const quantityPattern = /[0-9]/;
      if (!quantityPattern.test(quantity)) {
        alert("Proszę podać liczbę worków")
        return false;
      }
      if (quantity <= 0) {
        alert("Liczba worków musi być większa od zera");
        return false;
      }
      return true;
    }


    validateForm3() {
      const institution = document.querySelector('input[name="institution"]:checked');
      if (!institution) {
        alert("Proszę wybrać organizację.");
        return false;
      }
      return true;
    }


    validateForm4() {
      let isValid = true;
      let stringBuilder = [];

      const street = document.querySelector('input[name="street"]').value;
      if (street.length===0) {
        stringBuilder.push("Proszę podać ulicę.")
      }

      const city = document.querySelector('input[name="city"]').value;
      if (city.length===0) {
        stringBuilder.push("Proszę podać miasto.")
      }

      const zipCode = document.querySelector('input[name="zipCode"]').value;
      const zipCodePattern = /^[0-9]{2}-[0-9]{3}$/;

      if (zipCode.length===0) {
        stringBuilder.push("Proszę podać kod pocztowy.")
      }

      if (zipCode.length!==0 && !zipCodePattern.test(zipCode)) {
        stringBuilder.push("Proszę podać kod pocztowy w formacie 00-000.")
        isValid = false;
      }

      const phone = document.querySelector('input[name="phone"]').value;
      const phonePattern = /^\+?[0-9]+$/;

      if (phone.length===0) {
        stringBuilder.push("Proszę podać numer telefonu.")
      }
      if (phone.length!==0 && !phonePattern.test(phone)) {
        stringBuilder.push("Proszę podać poprawny numer telefonu (same cyfry, opcjonalnie z plusem).")
        isValid = false;
      }

      const pickUpDate = document.querySelector('input[name="pickUpDate"]').value;
      const today = new Date().toISOString().split('T')[0];
      if (pickUpDate.length===0) {
        stringBuilder.push("Proszę podać datę.")
      }
      if (pickUpDate.length!==0 && pickUpDate < today) {
        stringBuilder.push("Data odbioru nie może być wcześniejsza niż dzisiaj.")
        isValid = false;
      }

      const pickUpTime = document.querySelector('input[name="pickUpTime"]').value;
      if (pickUpTime.length===0) {
        stringBuilder.push("Proszę podać godzinę.")
        isValid = false;
      }
      const [hours] = pickUpTime.split(':');
      if (pickUpTime.length!==0 && (hours < 7 || hours > 20)) {
        stringBuilder.push("Godzina odbioru musi być między 7:00 a 20:00.")
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
