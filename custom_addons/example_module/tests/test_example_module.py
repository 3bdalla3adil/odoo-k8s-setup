from odoo.tests.common import TransactionCase

class TestExampleModule(TransactionCase):
    def setUp(self):
        super().setUp()
        self.ExampleRecord = self.env['example.module.record']

    def test_create_record(self):
        record = self.ExampleRecord.create({'name': 'Test Record', 'value': 10})
        self.assertEqual(record.name, 'Test Record')
        self.assertEqual(record.value, 10)

    def test_double_value(self):
        record = self.ExampleRecord.create({'name': 'Double Test', 'value': 5})
        record.double_value()
        self.assertEqual(record.value, 10)

    def test_negative_value_raises(self):
        with self.assertRaises(Exception):
            self.ExampleRecord.create({'name': 'Invalid', 'value': -1})

    def test_default_active(self):
        record = self.ExampleRecord.create({'name': 'Active Test', 'value': 0})
        self.assertTrue(record.active)
