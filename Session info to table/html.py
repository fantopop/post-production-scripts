#!/usr/bin/python

tab = '    '

class Tag():
    def __init__(self, name, HTML):
        self.name = name
        self.HTML = HTML
    def __enter__(self):
        self.HTML.content += tab * self.HTML.indent + '<' + self.name + '>\n'
        self.HTML.indent += 1
    def __exit__(self, exc_type, exc_value, traceback):
        self.HTML.indent -= 1
        self.HTML.content += tab * self.HTML.indent + '</' + self.name + '>\n'



class HTML():
    def __init__(self):
        self.indent = 0
        self.content = '<!DOCTYPE html>\n'
    def __str__(self):
        return self.content
    def add(self, text):
        for line in text.split('\n'):
            self.content += tab * self.indent + line + '\n'

    def html(self):
        return Tag('html', self)
    def body(self):
        return Tag('body', self)
    def head(self):
        return Tag('head', self)
    def title(self):
        return Tag('title', self)
    def h1(self):
        return Tag('h1', self)
    def h2(self):
        return Tag('h2', self)
    def style(self):
        return Tag('style', self)



def main():
    pass


if __name__ == '__main__':
    main()
