window.onload = function () {
  // Weight slider
  const weightSlider = document.getElementById("weightSlider");
  const weightLabel = document.getElementById("weightValue");

  // Height slider
  const heightSlider = document.getElementById("heightSlider");
  const heightLabel = document.getElementById("heightValue");

  const gymSlider = document.getElementById("gymdaysSlider");
  const gymLabel = document.getElementById("gymdaysValue");

  if (gymSlider && gymLabel) {
    gymSlider.oninput = function () {
      gymLabel.textContent = gymSlider.value;
    };

    gymLabel.textContent = gymSlider.value;
  }

  // BMI output
  const bmiLabel = document.getElementById("bmiValue");

  // Update everything together
  function updateSlidersAndBMI() {
    const weight = parseFloat(weightSlider.value);
    const height = parseFloat(heightSlider.value);

    weightLabel.textContent = weight;
    heightLabel.textContent = height;

    if (height && weight) {
      const heightInMeters = height / 100;
      const bmi = (weight / (heightInMeters * heightInMeters)).toFixed(1);
      bmiLabel.textContent = bmi;
    }
  }


  if (weightSlider && heightSlider) {
    weightSlider.oninput = updateSlidersAndBMI;
    heightSlider.oninput = updateSlidersAndBMI;

    // Call it once on load
    updateSlidersAndBMI();
  }

  // Optional dropdown logic
  window.toggleOtherDietField = function () {
    const dietSelect = document.getElementById("dietcurrent");
    const otherField = document.getElementById("otherDietField");
    otherField.style.display = dietSelect.value === "other_diet" ? "block" : "none";
  };

  window.toggleOtherDietaryField = function () {
    const dietarySelect = document.getElementById("dietaries");
    const otherField = document.getElementById("otherDietaryField");
    otherField.style.display = dietarySelect.value === "other_dietary" ? "block" : "none";
  };
};
