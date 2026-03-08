from odoo import models, fields, api

class ExampleModel(models.Model):
    _name = 'example.module.record'
    _description = 'Example Record'
    name = fields.Char(string='Name', required=True)
    value = fields.Integer(string='Value', default=0)
    active = fields.Boolean(string='Active', default=True)

    @api.constrains('value')
    def _check_value(self):
        for record in self:
            if record.value < 0:
                raise ValueError("Value must be non-negative.")

    def double_value(self):
        for record in self:
            record.value = record.value * 2
        return True
