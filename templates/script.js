// Only add event listener if the form exists
if (document.getElementById('fitnessForm')) {
    document.getElementById('fitnessForm').addEventListener('submit', function(event) {
      event.preventDefault();
  
      const name = document.getElementById('name') ? document.getElementById('name').value : 'N/A';
      const gymDays = document.getElementById('gymDays').value;
      const gymTime = document.getElementById('gymtime') ? document.getElementById('gymtime').value : 'N/A';
      const fitnessTarget = document.getElementById('fitnessTarget').value;
  
      const diet = document.querySelector('input[name="diet"]:checked')
        ? document.querySelector('input[name="diet"]:checked').value
        : 'N/A';
  
      const dietCurrent = document.getElementById('dietcurrent').value;
      const otherDietDetails = document.getElementById('otherDietField').style.display === 'block'
        ? document.getElementById('otherDietField').value
        : '';
  
      const otherDietaryDetails = document.getElementById('otherDietaryField').style.display === 'block'
        ? document.getElementById('otherDietaryField').value
        : '';
  
      const dietStrictness = document.getElementById('dietStrictness')
        ? document.getElementById('dietStrictness').value
        : 'N/A';
  
      const resultText = `
          Name/Alias: ${name}
          Gym Days: ${gymDays}
          Gym Time: ${updateOutput(gymTime, true)}
          Fitness Target: ${fitnessTarget}
          Diet: ${diet}
          Current Diet: ${dietCurrent}${otherDietDetails ? ' (Other: ' + otherDietDetails + ')' : ''}
          Dietary Requirement: ${otherDietaryDetails ? otherDietaryDetails : 'None'}
          Diet Strictness: ${dietStrictness}
      `;
  
      document.getElementById('result').innerText = resultText.trim();
    });
  }
  
  // Convert gym time from minutes to readable hours/mins
  function updateOutput(val) {
    const output = document.getElementById("gymtimeOutput");
    const hours = Math.floor(val / 60);
    const minutes = val % 60;
    let timeString = '';
  
    if (hours > 0) {
      timeString += hours + (hours === 1 ? ' hour ' : ' hours ');
    }
    if (minutes > 0) {
      timeString += minutes + ' mins';
    }
  
    if (output) {
      output.textContent = timeString.trim();
    }
  
    return timeString.trim();
  }
  
  // Show/hide "Other" text input for Current Diet
  function toggleOtherDietField() {
    const diet = document.getElementById("dietcurrent").value;
    const otherDietField = document.getElementById("otherDietField");
    otherDietField.style.display = (diet === "other_diet") ? "block" : "none";
  }
  
  // Show/hide "Other" text input for Dietary Requirements
  function toggleOtherDietaryField() {
    const dietary = document.getElementById("dietaries").value;
    const otherDietaryField = document.getElementById("otherDietaryField");
    otherDietaryField.style.display = (dietary === "other_dietary") ? "block" : "none";
  }

  document.querySelectorAll('.meal').forEach(meal => {
    meal.addEventListener('mousemove', function(e) {
      const img = meal.querySelector('img');
      if (img) {
        // Position the image 20px to the right of the cursor
        img.style.left = e.clientX + 15 + 'px';
        img.style.top = e.clientY + -450 + 'px';
      }
    });
    
    meal.addEventListener('mouseenter', function() {
      const img = meal.querySelector('img');
      if (img) {
        img.style.opacity = '1';
        img.style.transform = 'scale(1.25)';
      }
    });
    
    meal.addEventListener('mouseleave', function() {
      const img = meal.querySelector('img');
      if (img) {
        img.style.opacity = '0';
        img.style.transform = 'scale(1)';
      }
    });
  });
  