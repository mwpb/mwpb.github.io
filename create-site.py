import json
from jinja2 import Environment, FileSystemLoader, select_autoescape
env = Environment(
    loader=FileSystemLoader('templates'),
    autoescape=select_autoescape(['html', 'xml'])
)


# template_file = open('content/template.html', 'r')
# template_string = template_file.read()
# template_file.close()
# template = Template(template_string)

data_file = open('data.json', 'r')
data_string = data_file.read()
data_file.close()
data_object = json.loads(data_string)
talks = data_object["talks"]

content_files = [
	"index",
	"complexEigenvalues",
	"distinctEigenvalues",
	"introEigenvectors",
	"inverse-function-theorem",
	"software",
	"sorites",
	"writing",
	"papers",
	"talks"
	]

for filename in content_files:
	template = env.get_template("%s.html" % filename)
	if filename == "talks":
		output_string = template.render(talks = talks)
	else:
		output_string = template.render()
	output_file = open('%s.html' % filename,'w')
	output_file.write(output_string)
	output_file.close()