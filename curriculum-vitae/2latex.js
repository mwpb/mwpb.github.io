var fs = require('fs');

var string = fs.readFileSync('curriculum-vitae.json');
var obj = JSON.parse(string);


var education = obj.education;

// LaTeX formatting

var preamble = `
\\documentclass[10pt]{article}
\\usepackage[margin=3cm]{geometry}
\\setlength{\\parindent}{0in}
\\usepackage{tabu}
\\usepackage{longtable}
\\usepackage{url}
\\date{}
`;

var name = obj.name;
var email = obj.email;
var telephone = obj.telephone;
var website = obj.website;
var address = obj.address;

var addressList = address.split(';');

var details = `

\\section*{\\Huge ${name}}
\\begin{tabu}{@{}X[l6]X[r4]}
${addressList[0]} & Email: ${email} \\\\
${addressList[1]} & Telephone: ${telephone}\\\\
${addressList[2]} & Website: \\url{${website}}
\\end{tabu}
`;

// Academic Section
var experience = obj.academicExperience;
var academicSection = `
\\section*{Academic Employment}
\\begin{itemize}`;

for(var i=0;i<experience.length;i++){
    academicSection = academicSection + `
    \\item {\\bf ${experience[i].institution}}\\\\
    ${experience[i].title}, ${experience[i].years}.`;
    if (experience[i].notes.length == 0){
        console.log("No notes.");
    }
    else {
        academicSection = academicSection + `\\\\
        ${experience[i].notes}.`;
    }
}

academicSection = academicSection + '\n\\end{itemize}\n'

// Education Section
var education = obj.education;
var educationSection = `
\\section*{Education}
\\begin{itemize}`;

for(var i=0;i<education.length;i++){
    educationSection = educationSection + `
    \\item {\\bf ${education[i].institution}}\\\\
    ${education[i].title}, ${education[i].years}.\\\\
    ${education[i].notes[0]}.\\\\
    ${education[i].notes[1]}.`;
}

educationSection = educationSection + '\n\\end{itemize}\n'

// Teaching Section
var teaching = obj.teachingExperience;
var teachingSection = `
\\section*{Teaching and Work Experience}
\\begin{tabu}{X[1]X[5]}`;

for(var i=0;i<teaching.length;i++){
    teachingSection = teachingSection + `
    ${teaching[i].years} & \\bf{${teaching[i].title}}\\\\`;
    if (teaching[i].notes.length == 0){
        console.log("No notes.");
    }
    else {
        teachingSection = teachingSection + `
        {} & ${teaching[i].notes}\\\\`;
    }
}

teachingSection = teachingSection + '\n\\end{tabu}\n'

// Publications Section
var publications = obj.publications;
var publicationsSection = `
\\begin{itemize}`;

for(var i=0;i<publications.length;i++){
    publicationsSection = publicationsSection + `
    \\item ${publications[i].title}, \\emph{${publications[i].journal}}, ${publications[i].year}. Available at \\url{${publications[i].url}}.`;
}
var publicationsSectionInner = publicationsSection + '\n\\end{itemize}\n';
publicationsSection = '\\section*{Publications and Preprints}' + publicationsSection + '\n\\end{itemize}\n';

// Talks Section
var talks = obj.talks;
var talksSection = `
\\section*{Talks and Conferences}
\\begin{itemize}`;

for(var i=0;i<talks.length;i++){
    talksSection = talksSection + `
    \\item ${talks[i].venue}, \\emph{${talks[i].title}}, ${talks[i].institution}, ${talks[i].year}.`;
}

talksSection = talksSection + '\n\\end{itemize}\n'

var cv = preamble +
    '\\begin{document}' +
    details +
    academicSection +
    educationSection +
    publicationsSection +    
    teachingSection +
    talksSection +
    '\n\\end{document}';

console.log(cv);

// List of publications.

var listOfPublications = 
    preamble +
    `\\author{Matthew Burke}
    \\title{List of Publications}` +
    '\\begin{document}' +
    '\\maketitle' +
    publicationsSectionInner +
    '\n\\end{document}';    

fs.writeFileSync('./matthew-burke-cv.tex',cv);
fs.writeFileSync('./matthew-burke-publications.tex',listOfPublications);