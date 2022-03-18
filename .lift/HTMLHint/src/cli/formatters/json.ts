import { FormatterCallback } from '../formatter'

interface liftFormatter {
  type: String
  message: String
  file: String
  line: number
  details_url?: String
}

let liftOutput: liftFormatter[] = []

const jsonFormatter: FormatterCallback = function (formatter) {
  formatter.on('end', (event) => {
    //console.log(JSON.stringify(event.arrAllMessages[0].file));
    event.arrAllMessages.forEach((event, index) => {
      event.messages.forEach((m, i) => {
        let liftObj: liftFormatter = {
          type: m.type,
          message: m.message,
          file: event.file,
          line: m.line,
          details_url: m.rule.link,
        }
        liftOutput.push(liftObj)
      })
    })

    liftOutput.length == 0 ? process.stdout.write("[ ]") :process.stdout.write(JSON.stringify(liftOutput));
  })
}

module.exports = jsonFormatter
