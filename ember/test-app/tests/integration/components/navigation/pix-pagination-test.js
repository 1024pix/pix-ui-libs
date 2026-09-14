import { render } from '@1024pix/ember-testing-library';
import { click } from '@ember/test-helpers';
import { hbs } from 'ember-cli-htmlbars';
import { setupRenderingTest } from 'ember-qunit';
import { module, test } from 'qunit';
import sinon from 'sinon';

module('Integration | Component | pagination', function (hooks) {
  setupRenderingTest(hooks);

  test('Use PixPagination with texts', async function (assert) {
    // given
    const paginationData = {
      page: 1,
      pageSize: 10,
      rowCount: 2,
      pageCount: 1,
    };
    const texts = {
      title: 'Voir',
      pageSize: "Nombre d'élément à afficher par page",
      pageElementCount: '2 éléments',
      previousPage: 'Aller à la page précédente',
      pageNumber: 'Page 1 / 1',
      nextPage: 'Aller à la page suivante',
    };
    this.set('pagination', paginationData);
    this.set('texts', texts);
    // when
    await render(hbs`<PixPagination @pagination={{this.pagination}} @texts={{this.texts}} />`);

    const PixPaginationElement = this.element.querySelector('.pix-pagination');
    //then
    assert.ok(PixPaginationElement);
    assert.contains('Voir');
    assert.contains('2 éléments');
    assert.contains('Page 1 / 1');
  });

  test('Use texts to translate component', async function (assert) {
    // given
    const paginationData = {
      page: 1,
      pageSize: 10,
      rowCount: 2,
      pageCount: 1,
    };
    const texts = {
      title: 'See',
      pageSize: 'Number of items to display per page',
      pageElementCount: '2 items',
      previousPage: 'Go to previous page',
      pageNumber: 'Page 1 / 1',
      nextPage: 'Go to next page',
    };
    this.set('pagination', paginationData);
    this.set('texts', texts);

    // when
    await render(hbs`<PixPagination @pagination={{this.pagination}} @texts={{this.texts}} />`);

    const PixPaginationElement = this.element.querySelector('.pix-pagination');
    //then
    assert.ok(PixPaginationElement);
    assert.contains('See');
    assert.contains('2 items');
    assert.contains('Page 1 / 1');
  });

  module('PixPagination controls', function (hooks) {
    let onChangeStub, router, texts;

    hooks.beforeEach(function () {
      onChangeStub = sinon.stub();
      router = this.owner.lookup('service:router');
      router.replaceWith = sinon.stub();
      texts = {
        title: 'Voir',
        pageSize: "Nombre d'élément à afficher par page",
        pageElementCount: '1-10 sur 12 éléments',
        previousPage: 'Aller à la page précédente',
        pageNumber: 'Page 1 / 2',
        nextPage: 'Aller à la page suivante',
      };
    });

    test('should call onChange on pageSize change', async function (assert) {
      // given
      const paginationData = {
        page: 1,
        pageSize: 10,
        rowCount: 12,
        pageCount: 2,
      };

      this.set('pagination', paginationData);
      this.set('onChange', onChangeStub);
      this.set('texts', texts);

      // when
      const screen = await render(
        hbs`<PixPagination @pagination={{this.pagination}} @onChange={{this.onChange}} @texts={{this.texts}} />`,
      );

      await click(screen.getByLabelText("Nombre d'élément à afficher par page"));

      const optionLine = await screen.findByRole('option', { name: '50' });

      await click(optionLine);

      // then
      assert.ok(
        router.replaceWith.calledWithExactly({ queryParams: { pageSize: 50, pageNumber: 1 } }),
      );
      assert.ok(onChangeStub.called);
    });

    test('should call onChange on nextPage action', async function (assert) {
      // given
      const paginationData = {
        page: 1,
        pageSize: 10,
        rowCount: 12,
        pageCount: 2,
      };

      this.set('pagination', paginationData);
      this.set('onChange', onChangeStub);
      this.set('texts', texts);

      // when
      const screen = await render(
        hbs`<PixPagination @pagination={{this.pagination}} @onChange={{this.onChange}} @texts={{this.texts}} />`,
      );

      await click(screen.getByRole('button', { name: 'Aller à la page suivante', exact: false }));

      // then
      assert.ok(router.replaceWith.calledWithExactly({ queryParams: { pageNumber: 2 } }));
      assert.ok(onChangeStub.called);
    });

    test('should call onChange on previousPage action', async function (assert) {
      // given
      const paginationData = {
        page: 2,
        pageSize: 10,
        rowCount: 12,
        pageCount: 2,
      };

      this.set('pagination', paginationData);
      this.set('onChange', onChangeStub);
      this.set('texts', texts);

      // when
      const screen = await render(
        hbs`<PixPagination @pagination={{this.pagination}} @onChange={{this.onChange}} @texts={{this.texts}} />`,
      );

      await click(screen.getByRole('button', { name: 'Aller à la page précédente', exact: false }));

      // then
      assert.ok(router.replaceWith.calledWithExactly({ queryParams: { pageNumber: 1 } }));
      assert.ok(onChangeStub.called);
    });
  });

  test('When pagination params have options to display several pages', async function (assert) {
    // given
    const paginationData = {
      page: 2,
      pageSize: 10,
      rowCount: 12,
      pageCount: 2,
    };
    const texts = {
      title: 'Voir',
      pageSize: "Nombre d'élément à afficher par page",
      pageElementCount: '11-12 sur 12 éléments',
      previousPage: 'Aller à la page précédente',
      pageNumber: 'Page 2 / 2',
      nextPage: 'Aller à la page suivante',
    };
    this.set('pagination', paginationData);
    this.set('texts', texts);

    // when
    await render(hbs`<PixPagination @pagination={{this.pagination}} @texts={{this.texts}} />`);

    const PixPaginationElement = this.element.querySelector('.pix-pagination');
    //then
    assert.ok(PixPaginationElement);
    assert.contains('Voir');
    assert.contains('11-12 sur 12 éléments');
    assert.contains('Page 2 / 2');
  });

  test('When params isCondensed is true', async function (assert) {
    // given
    const paginationData = {
      page: 2,
      pageSize: 10,
      rowCount: 12,
      pageCount: 2,
    };
    const texts = {
      title: 'Voir',
      pageSize: "Nombre d'élément à afficher par page",
      pageElementCount: '11-12 sur 12 éléments',
      previousPage: 'Aller à la page précédente',
      pageNumber: 'Page 2 / 2',
      nextPage: 'Aller à la page suivante',
    };
    this.set('pagination', paginationData);
    this.set('texts', texts);
    // when
    await render(
      hbs`<PixPagination @pagination={{this.pagination}} @texts={{this.texts}} @isCondensed='true' />`,
    );

    const PixPaginationCondensedElement = this.element.querySelector('.pix-pagination-condensed');
    //then
    assert.ok(PixPaginationCondensedElement);
  });
});
