'use strict';
Object.defineProperty(exports, '__esModule', { value: true });
var workflow_1 = require('../js/workflow');
describe('Unit: Workflow', function() {
  it('write() should output to stdout', function() {
    var spy = jest.spyOn(console, 'log');
    workflow_1.write('Write to stdout');
    expect(spy).toHaveBeenCalledWith('Write to stdout');
    spy.mockReset();
    spy = jest.spyOn(console, 'log');
    workflow_1.write({ output: 'Write to stdout' });
    expect(spy).toHaveBeenCalledWith('{"output":"Write to stdout"}');
    spy.mockReset();
  });
  it('writeError() should output to stdout', function() {
    var spy = jest.spyOn(console, 'log');
    workflow_1.writeError('Write to stdout');
    expect(spy).toHaveBeenCalledWith('Error:', 'Write to stdout');
  });
  describe('Class: Query', function() {
    it('should throw when instantiated with null or undefined', function() {
      expect(function() {
        return new workflow_1.Query(null);
      }).toThrow(/Not a valid query: null/);
      expect(function() {
        return new workflow_1.Query(undefined);
      }).toThrow(/Not a valid query: undefined/);
    });
    describe('find()', function() {
      it('should return an array of matches', function() {
        var query = new workflow_1.Query('Get milk @important @store !!1');
        expect(query.find('milk')).toEqual(['milk']);
        expect(query.find(/!!\d/)).toEqual(['!!1']);
        expect(query.find(/@[^ ]+/)).toEqual(['@important', '@store']);
      });
      it('should return an array of matched groups', function() {
        var query = new workflow_1.Query('Get milk @important @store !!1');
        expect(query.find(/!!(\d)/)).toEqual(['1']);
        expect(query.find(/@([^ ]+)/)).toEqual(['important', 'store']);
      });
      it('should return null if the mutated string is empty', function() {
        var query = new workflow_1.Query('Get milk @important @store !!1');
        query.mutated = '';
        expect(query.find(/.+/)).toBe(null);
      });
      it('should return null when no match was found', function() {
        var query = new workflow_1.Query('Get milk @important @store !!1');
        expect(query.find('coffee')).toBe(null);
        expect(query.find(/coffee/)).toBe(null);
      });
    });
    describe('findAndRemove()', function() {
      it('should remove matches from query', function() {
        var query = new workflow_1.Query('Get milk @important @store !!1');
        expect(query.findAndRemove('@important')).toEqual(['@important']);
        expect(query.find('@important')).toBe(null);
        expect(query.query).toBe('Get milk @important @store !!1');
        expect(query.mutated).toBe('Get milk  @store !!1');
        expect(query.findAndRemove(/@[^ ]+/)).toEqual(['@store']);
        expect(query.find('@store')).toBe(null);
        expect(query.query).toBe('Get milk @important @store !!1');
        expect(query.mutated).toBe('Get milk   !!1');
      });
    });
    describe('update()', function() {
      it('should replace a match with replacement', function() {
        var query = new workflow_1.Query('Get milk @important @store !!1');
        expect(query.update('milk', 'coffee')).toBe(
          'Get coffee @important @store !!1'
        );
        query = new workflow_1.Query('Get milk @important @store !!1');
        expect(query.update(/@[^ ]+/, '@bla')).toBe('Get milk @bla @bla !!1');
        query = new workflow_1.Query('Get milk @important @store !!1');
        expect(query.update(/@([^ ]+)/, '$1')).toBe(
          'Get milk important store !!1'
        );
        // Escape special characters
        query = new workflow_1.Query('Get milk {(@important)} @store !!1');
        expect(query.update('{(@important)}', '@nothing')).toBe(
          'Get milk @nothing @store !!1'
        );
      });
    });
    describe('remove()', function() {
      it('should replace a match with empty string', function() {
        var query = new workflow_1.Query('Get milk @important @store !!1');
        expect(query.remove('milk ')).toBe('Get @important @store !!1');
        query = new workflow_1.Query('Get milk @important @store !!1');
        expect(query.remove(/@[^ ]* ?/)).toBe('Get milk !!1');
      });
    });
    describe('trigger()', function() {
      it('should return a list when a match is found', function() {
        var query = new workflow_1.Query('Get milk @');
        var list = new workflow_1.List([
          { title: 'First' },
          { title: 'Second' }
        ]);
        expect(query.trigger(/@/, /@(.*?)$/, list)).toEqual(list);
      });
      it('should do a weighted match', function() {
        var query = new workflow_1.Query('Get milk @s');
        var list = new workflow_1.List([
          { title: 'First' },
          { title: 'Second' }
        ]);
        expect(query.trigger(/@.*?$/, /@(.*?)$/, list)).toEqual(
          new workflow_1.List([{ title: 'Second' }, { title: 'First' }])
        );
      });
      it('should do a fuzzy match', function() {
        var query = new workflow_1.Query('Get milk @it');
        var list = new workflow_1.List([
          { title: 'First' },
          { title: 'Second' }
        ]);
        expect(query.trigger(/@.*?$/, /@(.*?)$/, list)).toEqual(
          new workflow_1.List([{ title: 'First' }])
        );
      });
      it('should reutun an empty List when no match is found', function() {
        var query = new workflow_1.Query('Get milk @q');
        var list = new workflow_1.List([
          { title: 'First' },
          { title: 'Second' }
        ]);
        expect(query.trigger(/#/, /#(.*?)$/, list)).toEqual(
          new workflow_1.List()
        );
      });
    });
  });
  describe('Class: Item', function() {
    it('should throw when instantiated without valid a title', function() {
      expect(function() {
        return new workflow_1.Item({ title: '' });
      }).toThrow(/Items need at least a title/);
    });
    it('should be instantiated with properties (without options)', function() {
      var item = new workflow_1.Item({ title: 'Test this' });
      expect(item).toHaveProperty('title', 'Test this');
      expect(item).toHaveProperty('uid');
      expect(item).toHaveProperty('arg', '');
      expect(item).toHaveProperty('type', 'default');
      expect(item).toHaveProperty('valid', true);
      expect(item).toHaveProperty('autocomplete', '');
      expect(item).toHaveProperty('icon', 'icon.png');
      expect(item).toHaveProperty('subtitle', 'Hit ENTER');
    });
    it('should be instantiated with properties (without options)', function() {
      var item = new workflow_1.Item({
        title: 'Test this',
        uid: 'uid',
        arg: 'arg',
        type: 'type',
        valid: false,
        autocomplete: 'autocomplete',
        icon: 'icon',
        subtitle: 'subtitle'
      });
      expect(item).toHaveProperty('title', 'Test this');
      expect(item).toHaveProperty('uid', 'uid');
      expect(item).toHaveProperty('arg', 'arg');
      expect(item).toHaveProperty('type', 'type');
      expect(item).toHaveProperty('valid', false);
      expect(item).toHaveProperty('autocomplete', 'autocomplete');
      expect(item).toHaveProperty('icon', 'icon');
      expect(item).toHaveProperty('subtitle', 'subtitle');
    });
    describe('setTitle()', function() {
      it('should set title property', function() {
        var item = new workflow_1.Item({ title: 'setTitle()' });
        item.setTitle('new Title');
        expect(item.title).toBe('new Title');
      });
    });
    describe('setSubtitle()', function() {
      it('should set subtitle property', function() {
        var item = new workflow_1.Item({ title: 'setSubtitle()' });
        item.setSubtitle('new Subtitle');
        expect(item.subtitle).toBe('new Subtitle');
      });
    });
    describe('setArg()', function() {
      it('should set arg property', function() {
        var item = new workflow_1.Item({ title: 'setArg()' });
        item.setArg('new Arg');
        expect(item.arg).toBe('new Arg');
      });
    });
    describe('setAutocomplete()', function() {
      it('should set autocomplete property', function() {
        var item = new workflow_1.Item({ title: 'setAutocomplete()' });
        item.setAutocomplete('new Autocomplete');
        expect(item.autocomplete).toBe('new Autocomplete');
      });
      it('should prefix autocomplete property', function() {
        var item = new workflow_1.Item({ title: 'setAutocomplete()' });
        item.setAutocomplete('new Autocomplete');
        item.setAutocomplete('This is the ', true);
        expect(item.autocomplete).toBe('This is the new Autocomplete');
      });
    });
    describe('write()', function() {
      it('should wirite to stdout', function() {
        var spy = jest.spyOn(console, 'log');
        var item = new workflow_1.Item({ title: 'write()' });
        item.write();
        expect(spy).toHaveBeenCalledWith(JSON.stringify(item));
      });
    });
  });
  describe('Class: List', function() {
    it('should create items instance property', function() {
      var list = new workflow_1.List();
      expect(list.items).toEqual([]);
    });
    it('should add items as Item instances', function() {
      var list = new workflow_1.List([{ title: 'list' }]);
      expect(list.items).toEqual([new workflow_1.Item({ title: 'list' })]);
    });
    describe('add()', function() {
      it('should accept WorkflowItems and Item instances', function() {
        var list = new workflow_1.List();
        list.add({ title: 'list1' });
        list.add(new workflow_1.Item({ title: 'list2' }));
        expect(list.items).toEqual([
          new workflow_1.Item({ title: 'list1' }),
          new workflow_1.Item({ title: 'list2' })
        ]);
      });
    });
    describe('capAt()', function() {
      it('should force a maximum list length', function() {
        var item = new workflow_1.Item({ title: 'List item' });
        var list = new workflow_1.List([item, item, item, item, item]);
        expect(list.items).toHaveLength(5);
        expect(list.capAt(3).items).toHaveLength(3);
      });
    });
    describe('autocompleteAll()', function() {
      it('should prefix all list items autocomplete value', function() {
        var item = new workflow_1.Item({
          title: 'List item',
          autocomplete: 'BOOM'
        });
        var list = new workflow_1.List([item, item, item, item, item]);
        list.autocompleteAll('ka-');
        expect(
          list.items.map(function(item) {
            return item.autocomplete;
          })
        ).toEqual([
          'ka-ka-ka-ka-ka-BOOM',
          'ka-ka-ka-ka-ka-BOOM',
          'ka-ka-ka-ka-ka-BOOM',
          'ka-ka-ka-ka-ka-BOOM',
          'ka-ka-ka-ka-ka-BOOM'
        ]);
      });
    });
    describe('filter()', function() {
      it('should return a list with fuzzy matched items', function() {
        var todo = new workflow_1.Item({ title: 'Get milk @shopping, today' });
        var doing = new workflow_1.Item({ title: 'Project X #work @1hour' });
        var done = new workflow_1.Item({ title: 'Have a walk @outside' });
        var list = new workflow_1.List([todo, doing, done]);
        // Matches ..#WOrk.. but also ..Walk @Out..
        expect(list.filter('wo')).toEqual(new workflow_1.List([doing, done]));
      });
    });
    describe('merge()', function() {
      it('should add lists to current list instance', function() {
        var todo = new workflow_1.Item({ title: 'Get milk @shopping, today' });
        var doing = new workflow_1.Item({ title: 'Project X #work @1hour' });
        var done = new workflow_1.Item({ title: 'Have a walk @outside' });
        var list = new workflow_1.List([todo]);
        list.merge(new workflow_1.List([doing]), new workflow_1.List([done]));
        expect(list.items).toHaveLength(3);
        expect(list).toEqual(new workflow_1.List([todo, doing, done]));
      });
    });
    describe('write()', function() {
      it('should write to stdout', function() {
        var spy = jest.spyOn(console, 'log');
        var item = new workflow_1.Item({ title: 'write()' });
        var list = new workflow_1.List([item]);
        list.write();
        expect(spy).toHaveBeenCalledWith(JSON.stringify(list));
      });
    });
  });
});
