// app/javascript/controllers/datepicker_controller.js
import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

export default class extends Controller {
  static targets = ["datepicker", "startDate", "endDate"];

  connect() {
    console.log("Datepicker controller connected");
    const bookedDates = JSON.parse(this.element.dataset.bookedDates || "[]").map(date => new Date(date));
    console.log("Booked dates received:", bookedDates);

    flatpickr(this.datepickerTarget, {
      mode: "range",
      dateFormat: "d/m/Y",
      disable: bookedDates,
      minDate: "today",
      locale: {
        firstDayOfWeek: 1
      },
      onChange: (selectedDates) => {
        if (selectedDates.length === 2) {
          const formatDate = (date) => {
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, "0");
            const day = String(date.getDate()).padStart(2, "0");
            return `${year}-${month}-${day}`;
          };
          if (this.hasStartDateTarget) {
            this.startDateTarget.value = formatDate(selectedDates[0]);
          } else {
            console.error("StartDate target not found");
          }
          if (this.hasEndDateTarget) {
            this.endDateTarget.value = formatDate(selectedDates[1]);
          } else {
            console.error("EndDate target not found");
          }
        }
      }
    });
  }
}
