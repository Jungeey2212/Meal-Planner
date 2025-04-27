// Debounce function to improve performance on events that fire rapidly
function debounce(func, wait = 300) {
  let timeout;
  return function executedFunction(...args) {
    const later = () => {
      clearTimeout(timeout);
      func(...args);
    };
    clearTimeout(timeout);
    timeout = setTimeout(later, wait);
  };
}

// Login and redirect function for index page
function redirectToDashboard(event) {
  event.preventDefault();
  
  // First validate the form
  const loginForm = document.getElementById('loginForm');
  if (!formValidator.validateForm(loginForm)) {
    return;
  }
  
  const email = document.getElementById("email").value.trim();
  const password = document.getElementById("password").value.trim();
  
  if (email && password) {
    // In a real application, you'd verify credentials before redirecting
    // For demo purposes, we're just redirecting to form1
    window.location.href = "form1";
  }
}

// Form persistence handling
const formStorage = {
  saveFormData: function(formId, data) {
    localStorage.setItem(formId, JSON.stringify(data));
  },
  
  loadFormData: function(formId) {
    const savedData = localStorage.getItem(formId);
    return savedData ? JSON.parse(savedData) : null;
  },
  
  collectFormData: function(form) {
    const formData = {};
    const elements = form.elements;
    
    for (let i = 0; i < elements.length; i++) {
      const element = elements[i];
      if (element.name && element.name !== "") {
        if (element.type === "checkbox") {
          formData[element.name] = element.checked;
        } else if (element.type === "radio") {
          if (element.checked) {
            formData[element.name] = element.value;
          }
        } else if (element.type !== "button" && element.type !== "submit") {
          formData[element.name] = element.value;
        }
      }
    }
    
    return formData;
  },
  
  populateForm: function(form, data) {
    if (!data) return;
    
    const elements = form.elements;
    for (let i = 0; i < elements.length; i++) {
      const element = elements[i];
      if (element.name && data[element.name] !== undefined) {
        if (element.type === "checkbox") {
          element.checked = data[element.name];
        } else if (element.type === "radio") {
          element.checked = (element.value === data[element.name]);
        } else if (element.type !== "button" && element.type !== "submit") {
          element.value = data[element.name];
        }
      }
    }
  }
};

// BMI calculator with classification
const bmiCalculator = {
  calculate: function(weight, height) {
    if (!height || !weight) return { value: "---", category: "", description: "" };
    
    const heightInMeters = height / 100;
    const bmi = weight / (heightInMeters * heightInMeters);
    const roundedBmi = Math.round(bmi * 10) / 10; // Round to 1 decimal place
    
    let category, description, categoryClass;
    
    if (bmi < 18.5) {
      category = "Underweight";
      categoryClass = "underweight";
      description = "Consider consulting with a healthcare professional about a healthy weight gain plan.";
    } else if (bmi >= 18.5 && bmi < 25) {
      category = "Normal";
      categoryClass = "normal";
      description = "You're at a healthy weight. Maintain a balanced diet and regular exercise.";
    } else if (bmi >= 25 && bmi < 30) {
      category = "Overweight";
      categoryClass = "overweight";
      description = "Consider moderate weight loss through improved diet and increased physical activity.";
    } else {
      category = "Obese";
      categoryClass = "obese";
      description = "Consider talking to a healthcare provider about weight management strategies.";
    }
    
    return {
      value: roundedBmi.toString(),
      category: category,
      description: description,
      categoryClass: categoryClass
    };
  }
};

// Form validation
const formValidator = {
  validateForm: function(form) {
    let isValid = true;
    const requiredElements = form.querySelectorAll('[required]');
    
    // Clear previous error messages
    const errorMessages = form.querySelectorAll('.error-message');
    errorMessages.forEach(element => {
      element.textContent = '';
    });
    
    requiredElements.forEach(element => {
      // Check if the element has a value
      if (!element.value || element.value === '') {
        isValid = false;
        const errorElement = document.getElementById(`${element.id}-error`);
        if (errorElement) {
          errorElement.textContent = 'This field is required.';
        }
        element.setAttribute('aria-invalid', 'true');
        
        // Apply error styling
        element.classList.add('input-error');
      } else {
        element.setAttribute('aria-invalid', 'false');
        element.classList.remove('input-error');
      }
      
      // Additional validation for number inputs
      if (element.type === 'number' && element.value !== '') {
        const min = parseFloat(element.getAttribute('min'));
        const max = parseFloat(element.getAttribute('max'));
        const value = parseFloat(element.value);
        
        if (!isNaN(min) && value < min) {
          isValid = false;
          const errorElement = document.getElementById(`${element.id}-error`);
          if (errorElement) {
            errorElement.textContent = `Value must be at least ${min}.`;
          }
          element.setAttribute('aria-invalid', 'true');
          element.classList.add('input-error');
        } else if (!isNaN(max) && value > max) {
          isValid = false;
          const errorElement = document.getElementById(`${element.id}-error`);
          if (errorElement) {
            errorElement.textContent = `Value must be at most ${max}.`;
          }
          element.setAttribute('aria-invalid', 'true');
          element.classList.add('input-error');
        }
      }
      
      // Email validation
      if (element.type === 'email' && element.value !== '') {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(element.value)) {
          isValid = false;
          const errorElement = document.getElementById(`${element.id}-error`);
          if (errorElement) {
            errorElement.textContent = 'Please enter a valid email address.';
          }
          element.setAttribute('aria-invalid', 'true');
          element.classList.add('input-error');
        }
      }
    });
    
    return isValid;
  },
  
  // Add real-time validation for individual fields
  setupRealTimeValidation: function(form) {
    if (!form) return;
    
    const requiredElements = form.querySelectorAll('[required]');
    requiredElements.forEach(element => {
      element.addEventListener('blur', function() {
        // Don't validate if the user hasn't interacted with the field yet
        if (!this.dataset.interacted) {
          this.dataset.interacted = 'true';
          return;
        }
        
        const errorElement = document.getElementById(`${this.id}-error`);
        
        if (!this.value || this.value === '') {
          if (errorElement) {
            errorElement.textContent = 'This field is required.';
          }
          this.setAttribute('aria-invalid', 'true');
          this.classList.add('input-error');
        } else {
          if (errorElement) {
            errorElement.textContent = '';
          }
          this.setAttribute('aria-invalid', 'false');
          this.classList.remove('input-error');
          
          // Additional validation for number inputs
          if (this.type === 'number') {
            const min = parseFloat(this.getAttribute('min'));
            const max = parseFloat(this.getAttribute('max'));
            const value = parseFloat(this.value);
            
            if (!isNaN(min) && value < min) {
              if (errorElement) {
                errorElement.textContent = `Value must be at least ${min}.`;
              }
              this.setAttribute('aria-invalid', 'true');
              this.classList.add('input-error');
            } else if (!isNaN(max) && value > max) {
              if (errorElement) {
                errorElement.textContent = `Value must be at most ${max}.`;
              }
              this.setAttribute('aria-invalid', 'true');
              this.classList.add('input-error');
            }
          }
          
          // Email validation
          if (this.type === 'email') {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(this.value)) {
              if (errorElement) {
                errorElement.textContent = 'Please enter a valid email address.';
              }
              this.setAttribute('aria-invalid', 'true');
              this.classList.add('input-error');
            }
          }
        }
      });
    });
  }
};

// Dark mode toggle
const themeToggle = {
  init: function() {
    console.log("Initializing theme toggle");
    const darkModeToggle = document.getElementById('darkModeToggle');
    if (!darkModeToggle) {
      console.log("Dark mode toggle not found");
      return;
    }
    
    // Check for saved theme preference or respect OS preference
    const savedTheme = localStorage.getItem('theme');
    const prefersDarkMode = window.matchMedia('(prefers-color-scheme: dark)').matches;
    
    // Apply theme
    if (savedTheme === 'dark' || (!savedTheme && prefersDarkMode)) {
      document.body.classList.add('dark-mode');
      darkModeToggle.checked = true;
    }
    
    // Toggle theme when checkbox is changed
    darkModeToggle.addEventListener('change', function() {
      console.log("Dark mode toggle changed:", this.checked);
      if (this.checked) {
        document.body.classList.add('dark-mode');
        localStorage.setItem('theme', 'dark');
      } else {
        document.body.classList.remove('dark-mode');
        localStorage.setItem('theme', 'light');
      }
    });
  }
};

// Define updateSlidersAndBMI function
const updateSlidersAndBMI = debounce(function() {
  const weightSlider = document.getElementById('weightSlider');
  const heightSlider = document.getElementById('heightSlider');
  const weightLabel = document.getElementById('weightValue');
  const heightLabel = document.getElementById('heightValue');
  const bmiLabel = document.getElementById('bmiValue');
  const bmiCategory = document.getElementById('bmiCategory');
  const bmiDescription = document.getElementById('bmiDescription');
  
  if (!weightSlider || !heightSlider) return;
  
  const weight = parseFloat(weightSlider.value);
  const height = parseFloat(heightSlider.value);
  
  if (weightLabel) weightLabel.textContent = weight;
  if (heightLabel) heightLabel.textContent = height;
  
  // Update ARIA values for accessibility
  weightSlider.setAttribute('aria-valuenow', weight);
  heightSlider.setAttribute('aria-valuenow', height);
  
  const bmiResults = bmiCalculator.calculate(weight, height);
  
  if (bmiLabel) bmiLabel.textContent = bmiResults.value;
  
  if (bmiCategory) {
    bmiCategory.textContent = bmiResults.category;
    
    // Reset classes
    bmiCategory.className = 'bmi-category';
    
    // Add appropriate class based on category
    if (bmiResults.categoryClass) {
      bmiCategory.classList.add(bmiResults.categoryClass);
    }
  }
  
  if (bmiDescription) {
    bmiDescription.textContent = bmiResults.description;
  }
}, 100);

// Initialization function
window.onload = function() {
  console.log("Window loaded");
  
  // Get form elements
  const loginForm = document.getElementById('loginForm');
  const form1 = document.getElementById('fitnessForm1');
  const form2 = document.getElementById('fitnessForm2');
  const form3 = document.getElementById('fitnessForm3');
  
  // Handle login form if it exists
  if (loginForm) {
    // Set up real-time validation
    formValidator.setupRealTimeValidation(loginForm);
    
    // Only set up event listener if not using the redirectToDashboard function directly
    if (!loginForm.hasAttribute('onsubmit')) {
      loginForm.addEventListener('submit', function(event) {
        // Only prevent default if you want to handle submission in JS
        if (loginForm.getAttribute('action') === '#') {
          event.preventDefault();
          
          if (!formValidator.validateForm(loginForm)) {
            return;
          }
          
          // Here you would typically handle login logic
          // For now, redirect to form1
          window.location.href = "form1";
        }
      });
    }
  }
  
  // Sliders and labels
  const weightSlider = document.getElementById('weightSlider');
  const heightSlider = document.getElementById('heightSlider');
  const gymSlider = document.getElementById('gymdaysSlider');
  const gymLabel = document.getElementById('gymdaysValue');
  
  // Load saved form data if available
  if (form1) {
    const savedData = formStorage.loadFormData('fitnessForm1');
    formStorage.populateForm(form1, savedData);
    
    // Set up real-time validation
    formValidator.setupRealTimeValidation(form1);
    
    // Attach form submission handler
    form1.addEventListener('submit', function(event) {
      if (!formValidator.validateForm(form1)) {
        event.preventDefault();
        return;
      }
      
      const formData = formStorage.collectFormData(form1);
      formStorage.saveFormData('fitnessForm1', formData);
    });
    
    // Trigger update for sliders to make sure BMI is calculated
    if (weightSlider && heightSlider) {
      updateSlidersAndBMI();
    }
  }
  
  if (form2) {
    const savedData = formStorage.loadFormData('fitnessForm2');
    formStorage.populateForm(form2, savedData);
    
    // Set up real-time validation
    formValidator.setupRealTimeValidation(form2);
    
    form2.addEventListener('submit', function(event) {
      if (!formValidator.validateForm(form2)) {
        event.preventDefault();
        return;
      }
      
      const formData = formStorage.collectFormData(form2);
      formStorage.saveFormData('fitnessForm2', formData);
    });
    
    // Check if any "other" options are selected and show fields
    if (document.getElementById('dietcurrent')) {
      toggleOtherDietField();
    }
    
    if (document.getElementById('dietaries')) {
      toggleOtherDietaryField();
    }
  }
  
  if (form3) {
    const savedData = formStorage.loadFormData('fitnessForm3');
    formStorage.populateForm(form3, savedData);
    
    // Set up real-time validation
    formValidator.setupRealTimeValidation(form3);
    
    form3.addEventListener('submit', function(event) {
      if (!formValidator.validateForm(form3)) {
        event.preventDefault();
        return;
      }
      
      const formData = formStorage.collectFormData(form3);
      formStorage.saveFormData('fitnessForm3', formData);
    });
  }
  
  // Update gym days slider value
  if (gymSlider && gymLabel) {
    gymSlider.oninput = function() {
      gymLabel.textContent = gymSlider.value;
    };
    
    // Set initial value
    if (gymLabel) {
      gymLabel.textContent = gymSlider.value;
    }
  }
  
  // Set up slider event listeners
  if (weightSlider && heightSlider) {
    weightSlider.addEventListener('input', updateSlidersAndBMI);
    heightSlider.addEventListener('input', updateSlidersAndBMI);
    
    // Initial calculation
    updateSlidersAndBMI();
  }
  
  // Optional dropdown logic
  window.toggleOtherDietField = function() {
    const dietSelect = document.getElementById('dietcurrent');
    const otherField = document.getElementById('otherDietField');
    if (dietSelect && otherField) {
      otherField.style.display = dietSelect.value === 'other_diet' ? 'block' : 'none';
    }
  };
  
  window.toggleOtherDietaryField = function() {
    const dietarySelect = document.getElementById('dietaries');
    const otherField = document.getElementById('otherDietaryField');
    if (dietarySelect && otherField) {
      otherField.style.display = dietarySelect.value === 'other_dietary' ? 'block' : 'none';
    }
  };
  
  // Call toggles once on load to set initial state
  if (document.getElementById('dietcurrent')) {
    toggleOtherDietField();
  }
  
  if (document.getElementById('dietaries')) {
    toggleOtherDietaryField();
  }
  
  // Initialize dark mode toggle - must be done AFTER all elements are properly defined
  themeToggle.init();
  
  // Add console log for debugging
  console.log("Initialization complete");
};