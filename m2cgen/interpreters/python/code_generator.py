import contextlib

from m2cgen.interpreters.code_generator import ImperativeCodeGenerator
from m2cgen.interpreters.code_generator import CodeTemplate as CT


class PythonCodeGenerator(ImperativeCodeGenerator):

    tpl_num_value = CT("{value}")
    tpl_infix_expression = CT("({left}) {op} ({right})")
    tpl_return_statement = CT("return {value}")
    tpl_array_index_access = CT("{array_name}[{index}]")
    tpl_array_convert_to_numpy = CT("np.asarray({value})")
    tpl_if_statement = CT("if {if_def}:")
    tpl_else_statement = CT("else:")
    tpl_var_assignment = CT("{var_name} = {value}")

    tpl_var_declaration = CT("")
    tpl_block_termination = CT("")

    def add_function_def(self, name, args):
        method_def = "def " + name + "("
        method_def += ", ".join(args)
        method_def += "):"
        self.add_code_line(method_def)
        self.increase_indent()

    @contextlib.contextmanager
    def function_definition(self, name, args):
        self.add_function_def(name, args)
        yield

    def vector_init(self, values):
        return "[" + ", ".join(values) + "]"

    def array_convert_to_numpy(self, value):
        return self.tpl_array_convert_to_numpy(value=value)

    def add_dependency(self, dep, alias=None):
        dep_str = "import " + dep
        if alias:
            dep_str += " as " + alias
        super().prepend_code_line(dep_str)
