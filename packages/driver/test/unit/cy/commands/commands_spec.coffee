describe "$Cypress.Cy Commands", ->
  enterCommandTestingMode()

  it "can invoke commands by name", ->
    body = @cy.$$("body")

    @cy
      .get("body").then ($body) ->
        expect($body.get(0)).to.eq(body.get(0))
      .cmd("get", "body").then ($body) ->
        expect($body.get(0)).to.eq(body.get(0))

  it "can invoke child commands by name", ->
    div = @cy.$$("body>div:first")

    @cy
      .get("body").find("div:first").then ($div) ->
        expect($div.get(0)).to.eq(div.get(0))
      .get("body").cmd("find", "div:first").then ($div) ->
        expect($div.get(0)).to.eq(div.get(0))

  it "does not add cmds to cy.commands queue", ->
    @cy.cmd("get", "body").then ->
      names = @cy.queue.names()
      expect(names).to.deep.eq(["get", "then", "then"])

  context "custom commands", ->
    beforeEach ->
      @Cypress.Commands.add "dashboard.selectWindows", =>
        @cy
          .get("[contenteditable]")
          .first()

      @Cypress.Commands.add "login", { prevSubject: true }, (subject, email) =>
        @cy
          .wrap(subject.find("input:first"))
          .type(email)

    it "works with custom commands", ->
      input = @cy.$$("input:first")

      @cy
        .get("input:first")
        .parent()
        .cmd("login", "brian@foo.com").then ($input) ->
          expect($input.get(0)).to.eq(input.get(0))

    it "works with namespaced commands", ->
      ce = @cy.$$("[contenteditable]").first()

      @cy
        .command("dashboard.selectWindows").then ($ce) ->
          expect($ce.get(0)).to.eq(ce.get(0))

  context "errors", ->
    beforeEach ->
      @allowErrors()

    it "throws when cannot find command by name", ->
      try
        @cy.get("body").cmd("fooDoesNotExist", "bar", "baz")
      catch err
        cmds = _.keys($Cypress.Chainer.prototype)
        expect(cmds.length).to.be.gt(1)
        expect(err.message).to.eq("Could not find a command for: 'fooDoesNotExist'.\n\nAvailable commands are: #{cmds.join(", ")}.\n")