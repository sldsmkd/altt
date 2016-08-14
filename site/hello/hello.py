import re
import subprocess


def getip():
    """ quick hack to get IP address, only tested on Ubuntu """
    try:
        regex = "(inet addr:)(.+)( Bcast)"
        network = subprocess.check_output(['/sbin/ifconfig', 'eth1'])
        matches = re.search(regex, network)
        ip = matches.group(2)
    except:
        ip = "Unknown"
    finally:
        return  ip.strip()


def response():
    """ generate a simple hello world page """
    filename = "/vagrant/site/hello/template.html"
    template = open(filename).readlines()
    ip = getip()
    response = ""
    for line in template:
        response = response + line.replace("$IP", ip)
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
