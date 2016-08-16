import platform


def response():
    """ generate a simple hello world page """
    filename = "/vagrant/site/hello/template.html"
    template = open(filename).readlines()
    hostname = platform.node()
    response = ""
    for line in template:
        response = response + line.replace("$HOSTNAME", hostname)
    return response


def application(environ, start_response):
    """ minimal uwsgi app """
    status = '200 OK'
    response_body = response()
    response_headers = [('Content-type', 'text/html'),
                        ('Content-Length', str(len(response_body)))]
    start_response(status, response_headers)
    return [response_body]


if __name__ == "__main__":
    print response()
